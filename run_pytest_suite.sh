#!/bin/bash
set -e
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
REPORT_FILE="results/pytest_report_${TIMESTAMP}.html"
pytest API/suite_pytest/ \
  --html="${REPORT_FILE}" \
  --self-contained-html \
echo "Reporte generado: ${REPORT_FILE}"
