FROM gcr.io/dataflow-templates-base/python3-template-launcher-base

ARG WORKDIR=/dataflow/template

COPY . ${WORKDIR}

RUN pip install -U -r ${WORKDIR}/requirements.txt

WORKDIR ${WORKDIR}

ENV FLEX_TEMPLATE_PYTHON_SETUP_FILE="${WORKDIR}/setup.py"
ENV FLEX_TEMPLATE_PYTHON_PY_FILE="${WORKDIR}/dataflow_pipeline.py"
ENV FLEX_TEMPLATE_PYTHON_PY_OPTIONS=""
ENV FLEX_TEMPLATE_PYTHON_EXTRA_PACKAGES=""
ENV FLEX_TEMPLATE_PYTHON_REQUIREMENTS_FILE="${WORKDIR}/requirements.txt"