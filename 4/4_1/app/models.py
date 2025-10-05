from dataclasses import dataclass

@dataclass(frozen=True)
class InstanceSpec:
    name: str
    image: str
    size: str
    region: str
