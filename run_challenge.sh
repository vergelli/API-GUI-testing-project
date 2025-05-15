# run_all_tests.sh
#!/bin/bash
export PYTHONWARNINGS="ignore::DeprecationWarning"
mkdir -p results
pabot --processes 2 --outputdir . --quiet --console none GUI/suite/ API/suite/
rm -r tmpWorkdir/