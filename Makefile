# ========================
# Variables
# ========================
RESULTS_DIR    := results

# ========================
# Limpieza OJO!
# ========================
.PHONY: clean-results
clean-results:
	@echo "Borrando todos los resultados previos..."
	@rm -rf ${RESULTS_DIR}/* ${RESULTS_DIR}/.[!.]* ${RESULTS_DIR}/..?*
	@echo "✔️  Carpeta '${RESULTS_DIR}/' limpia."

# ========================
# Guardado de reportes con un ts por las dudas
# ========================
.PHONY: reports-save
reports-save:
	@echo "Guardando reportes..."
	@TIMESTAMP=$$(date +"%Y%m%d_%H%M%S"); \
	mkdir -p ${RESULTS_DIR}; \
	cp log.html     ${RESULTS_DIR}/log_$${TIMESTAMP}.html; \
	cp report.html  ${RESULTS_DIR}/report_$${TIMESTAMP}.html; \
	cp output.xml   ${RESULTS_DIR}/output_$${TIMESTAMP}.xml; \
	echo "Reportes guardados en '${RESULTS_DIR}/' con timestamp: $${TIMESTAMP}"; \
	echo "Eliminando archivos temporales..."; \
	rm -f log.html report.html output.xml
