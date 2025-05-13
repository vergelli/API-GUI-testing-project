# Variables
TEST_TAG ?= "TC 1.1"
TEST_DIR ?= GUI/
EVIDENCE_DIR ?= "results/${TEST_TAG}/reports/tmpWorkdir"

# Default target
.PHONY: test
test: clean run collect

# Limpia evidencias anteriores
.PHONY: clean
clean:
	rm -rf ${EVIDENCE_DIR}

# Ejecuta los tests con la tag dada
.PHONY: run
run:
	@echo "Running Robot tests with tag ${TEST_TAG}"
	robot -i "${TEST_TAG}" ${TEST_DIR}
	@echo "Tests completed. Collecting logs and reports."

TIMESTAMP := $(shell date +"%Y%m%d_%H%M%S")
RESULTS_DIR := results

.PHONY: collect
collect:
	mkdir -p ${RESULTS_DIR}
	cp log.html ${RESULTS_DIR}/log_${TIMESTAMP}.html
	cp report.html ${RESULTS_DIR}/report_${TIMESTAMP}.html
	cp output.xml ${RESULTS_DIR}/output_${TIMESTAMP}.xml
	@echo "Logs collected with timestamp in ${RESULTS_DIR}"
	@echo "Deleting original report files"
	rm -f log.html report.html output.xml

.PHONY: clean-results
clean-results:
	@echo "Deleting all results"
	rm -rf results/*
	@echo "✔️  'results/' clean."
