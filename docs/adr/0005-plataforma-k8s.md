# ADR 0005: Plataforma de despliegue: Kubernetes local (k3d) e IaC con Terraform

## Fecha
16/10/26

## Autores
Josefa Rodriguez, Lucas Benítez, Marcela Contreras, Isidora Ramos, Antonia Moya y Kimberlly Guillén

## Contexto
El ADR 0003 definió para MediTriage un monolito modular cloud-native empaquetado en una única imagen de Docker, pensada para desplegarse en servicios gestionados (AWS ECS Fargate o GCP Cloud Run). El mini-lab de esta sesión pide empaquetar y desplegar el servicio principal en Kubernetes, y definir parte de la infraestructura como código.

La pauta establece las siguientes restricciones:
- Un cluster local de Kubernetes (`kind`, `minikube` o `k3d`), con Docker Desktop y `kubectl` instalados.
- Terraform ≥ 1.6 con el provider de Kubernetes.
- Manifiestos de Kubernetes aplicados con Kustomize (`kubectl apply -k`).
- Un HPA configurado y probado.

El alcance es el servicio principal (backend). PostgreSQL y Redis no se despliegan en este entorno.

## Decisión
Se toman dos decisiones:
1. **Cluster local:** k3d.
2. **Infraestructura como código:** Terraform con el provider de Kubernetes, que crea el namespace `triageops` y el secret `triageops-secrets` (con valores placeholder). Los manifiestos de la aplicación (Deployment, Service, ConfigMap, Ingress y HPA) se aplican con Kustomize.

Terraform es el único responsable de crear el namespace y el secret. Kustomize no define esos recursos, para evitar conflictos de administración entre ambas herramientas.

Kubernetes se usa como plataforma de este mini-lab y no reemplaza el destino de producción definido en el ADR 0003 y en `managed-services.md`.

## Razones de la decisión

### Cluster local: k3d
1. **Ingress incluido:** k3s trae Traefik instalado por defecto, y el `ingress.yaml` del equipo usa `ingressClassName: traefik` sin instalar nada más.
2. **Metrics-server incluido:** el HPA necesita métricas de CPU para escalar, y k3s las provee desde el inicio. Esto permitió probar el autoescalado sin configuración adicional.
3. **Liviano y rápido de crear:** los nodos son contenedores Docker, lo que reduce el consumo de recursos en los equipos del grupo y permite recrear el cluster con un solo comando.
4. **Reproducible:** k3d se apoya en Docker Desktop, que la pauta ya exige, por lo que cualquier integrante puede levantar el mismo entorno.

### Infraestructura como código: Terraform
1. **Lo exige la pauta del mini-lab.** Esta es la razón principal de la elección.
2. **Plan revisable antes de aplicar:** `terraform plan` mostró exactamente qué recursos se iban a crear (2) antes de ejecutar `apply`.
3. **Parametrizable y seguro:** el nombre del namespace se define con una variable, y el valor del secret se declara como variable sensible (`sensitive`), por lo que no se muestra en los registros.
4. **Versionado y reproducible:** la configuración vive en `terraform/main.tf` dentro del repositorio y se ejecuta con `init`, `plan` y `apply`.

### Reparto entre Terraform y Kustomize
Cada recurso tiene un único dueño: Terraform administra el namespace y el secret, y Kustomize administra los manifiestos de la aplicación. Así se evita que dos herramientas intenten crear o modificar el mismo recurso.

## Evidencia de verificación
- **Estado del despliegue (`kubectl get all -n triageops`):** 2 pods en estado Running (1/1 listos, 0 reinicios), Deployment 2/2 disponible, Service de tipo ClusterIP en el puerto 80 y HPA con objetivo de 50 % de CPU, mínimo de 2 y máximo de 10 réplicas.
- **Prueba del HPA (`kubectl get hpa -w`):** con la carga de la prueba, la CPU subió hasta 190 % del objetivo y las réplicas pasaron de 2 a 4 y luego a 8. Con la carga estabilizada, el uso se mantuvo entre 35 % y 50 %. Unos minutos después de terminar la carga, las réplicas bajaron a 7, luego a 5 y finalmente a 2, el mínimo configurado.
- **Terraform:** `apply` terminó con `Resources: 2 added, 0 changed, 0 destroyed` (namespace `triageops` y secret `triageops-secrets`).

Las capturas están en el README del repositorio.

## Alternativas descartadas
Las siguientes opciones no se evaluaron en la práctica. Se mencionan solo como referencia.

### Cluster local
- **kind:** no incluye controlador de ingress ni metrics-server, por lo que habría que instalarlos aparte.
- **minikube:** requiere activar los addons de ingress y metrics-server, y según el driver puede consumir más recursos.
- **Kubernetes de Docker Desktop:** por defecto es un solo nodo y tampoco trae controlador de ingress.

### Infraestructura como código
- La pauta fijó Terraform, por lo que no se evaluaron otras herramientas. Como referencia, existen OpenTofu (compatible con Terraform) y Pulumi (infraestructura en lenguajes de programación).

### Despliegue sin Kubernetes
- AWS ECS Fargate y GCP Cloud Run (ADR 0003) se mantienen como destino de producción.

## Consecuencias

### Positivas
- Entorno local reproducible, con ingress y métricas disponibles desde el inicio.
- Autoescalado verificado: el HPA subió y bajó el número de réplicas según la carga.
- Responsabilidades claras entre Terraform y Kustomize, sin recursos duplicados.
- Ninguna credencial real en el repositorio: el secret usa valores placeholder.

### Negativas
- El estado de Terraform es local. El backend remoto (S3) está declarado en `main.tf` pero desactivado por falta de credenciales, y no incluye configuración de bloqueo (locking). Esto implica riesgo de perder el estado y de conflictos si más de una persona ejecuta Terraform. Al activarlo se debe agregar el bloqueo con `use_lockfile` o una tabla DynamoDB.
- k3d es un entorno de desarrollo y demostración, distinto de los servicios gestionados del destino de producción, aunque ambos ejecutan la misma imagen de Docker.
- Más complejidad operativa que la que el ADR 0003 buscaba evitar para un equipo de 6 personas. Se acota usando Kubernetes solo en este entorno.
- Dos herramientas que mantener (Terraform y Kustomize).
- Alcance limitado: el entorno valida el empaquetado, el arranque y el escalado del servicio, pero no su comportamiento con PostgreSQL y Redis.
