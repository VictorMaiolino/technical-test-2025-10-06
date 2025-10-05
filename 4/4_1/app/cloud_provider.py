from abc import ABC, abstractmethod
from .models import InstanceSpec

class CloudProvider(ABC):
    @abstractmethod
    def create_instance(self, spec: InstanceSpec) -> str:
        """Cria uma instância e retorna um id."""
        raise NotImplementedError

    @abstractmethod
    def delete_instance(self, instance_id: str) -> None:
        """Remove a instância pelo id."""
        raise NotImplementedError
