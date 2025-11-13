import yaml
import json

# Carrega o docker-compose.yaml
with open("docker-compose.yaml") as f:
    compose = yaml.safe_load(f)

container_definitions = []

# Itera sobre os serviços do docker-compose
for name, service in compose.get("services", {}).items():
    container_def = {
        "name": name,
        "image": service.get("image"),
        "cpu": 256,  # você pode ajustar
        "memory": 512,  # você pode ajustar
        "essential": True,
        "environment": [{"name": k, "value": str(v)} for k, v in service.get("environment", {}).items()],
        "portMappings": [],
    }

    ports = service.get("ports", [])
    for port in ports:
        if isinstance(port, str) and ":" in port:
            host_port, container_port = port.split(":")
        elif isinstance(port, int):
            host_port = container_port = port
        else:
            continue
        container_def["portMappings"].append({
            "containerPort": int(container_port),
            "hostPort": int(host_port),
            "protocol": "tcp"
        })

    container_definitions.append(container_def)

# Salva no JSON
with open("container_definitions.json", "w") as f:
    json.dump(container_definitions, f, indent=2)

print("container_definitions.json gerado com sucesso!")
