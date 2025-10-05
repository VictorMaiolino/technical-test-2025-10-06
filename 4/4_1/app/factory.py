import yaml
from pathlib import Path
from .providers.aws import AWSProvider
from .providers.azure import AzureProvider
from .cloud_provider import CloudProvider

class ProviderFactory:
    _REGISTRY = {
        "aws": AWSProvider,
        "azure": AzureProvider,
    }

    @staticmethod
    def from_yaml(config_path: str) -> tuple[CloudProvider, dict]:
        data = yaml.safe_load(Path(config_path).read_text(encoding="utf-8"))
        provider_key = str(data.get("provider", "")).lower()
        provider_cls = ProviderFactory._REGISTRY.get(provider_key)
        if not provider_cls:
            raise ValueError(f"Provedor inválido em config.yaml: '{provider_key}'. Use 'aws' ou 'azure'.")
        return provider_cls(), data.get("defaults", {}) or {}
