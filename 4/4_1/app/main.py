from .factory import ProviderFactory
from .models import InstanceSpec

def run(config_path: str = "config.yaml") -> None:
    provider, defaults = ProviderFactory.from_yaml(config_path)
    spec = InstanceSpec(
        name="demo-01",
        image=defaults.get("image", "ubuntu-22.04"),
        size=defaults.get("size", "t3.micro"),
        region=defaults.get("region", "us-east-1"),
    )
    instance_id = provider.create_instance(spec)
    # ... uso da instância ...
    provider.delete_instance(instance_id)

if __name__ == "__main__":
    run()
