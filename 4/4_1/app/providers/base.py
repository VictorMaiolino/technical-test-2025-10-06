from ..models import InstanceSpec

class BaseProvider:
    def _validate_spec(self, spec: InstanceSpec) -> None:
        if not all([spec.name, spec.image, spec.size, spec.region]):
            raise ValueError("Spec inválida: name, image, size e region são obrigatórios.")
