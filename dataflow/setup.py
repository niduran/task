import setuptools

REQUIRED_PACKAGES = [
    "apache-beam[gcp]",
    "google-cloud-secret-manager",
    "google-cloud-storage",
    "requests",
]

PACKAGE_NAME = "dataflow-production-ready-python"
PACKAGE_VERSION = "0.0.2"

setuptools.setup(
    name=PACKAGE_NAME,
    version=PACKAGE_VERSION,
    install_requires=REQUIRED_PACKAGES,
    packages=setuptools.find_packages(),
    include_package_data=True
)