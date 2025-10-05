import uuid
from .base import BaseProvider
from ..cloud_provider import CloudProvider
from ..models import InstanceSpec

class AWSProvider(BaseProvider, CloudProvider):
    def create_instance(self, spec: InstanceSpec) -> str:
        self._validate_spec(spec)
        instance_id = f"aws-{uuid.uuid4()}"
        # Aqui entraria boto3 (omitido): ec2.run_instances(...)
        print(f"[AWS] Criada instância {instance_id} em {spec.region} ({spec.size}, {spec.image})")
        return instance_id

    def delete_instance(self, instance_id: str) -> None:
        # boto3 terminate_instances(...) — omitido
        print(f"[AWS] Removida instância {instance_id}")
