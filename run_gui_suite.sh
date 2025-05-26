#!/bin/bash
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
SUITE_TYPE="GUI"
RESULTS_DIR="results"
echo "Ejecutando suite ${SUITE_TYPE}..."
robot GUI/suite/
echo "Guardando reportes..."
cp log.html     "${RESULTS_DIR}/log_${SUITE_TYPE}_${TIMESTAMP}.html"
cp report.html  "${RESULTS_DIR}/report_${SUITE_TYPE}_${TIMESTAMP}.html"
cp output.xml   "${RESULTS_DIR}/output_${SUITE_TYPE}_${TIMESTAMP}.xml"
echo "Eliminando archivos temporales..."
rm -f log.html report.html output.xml
echo "✔ Reportes guardados en '${RESULTS_DIR}/' con timestamp: ${TIMESTAMP}"
