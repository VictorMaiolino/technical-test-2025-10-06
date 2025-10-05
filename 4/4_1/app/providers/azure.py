import uuid
from .base import BaseProvider
from ..cloud_provider import CloudProvider
from ..models import InstanceSpec

class AzureProvider(BaseProvider, CloudProvider):
    def create_instance(self, spec: InstanceSpec) -> str:
        self._validate_spec(spec)
        instance_id = f"az-{uuid.uuid4()}"
        # Aqui entraria azure-mgmt (omitido): compute_client.virtual_machines.begin_create_or_update(...)
        print(f"[Azure] Criada instância {instance_id} em {spec.region} ({spec.size}, {spec.image})")
        return instance_id

    def delete_instance(self, instance_id: str) -> None:
        # azure-mgmt delete(...) — omitido
        print(f"[Azure] Removida instância {instance_id}")
