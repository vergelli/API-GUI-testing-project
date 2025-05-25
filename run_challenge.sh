# run_all_tests.sh
#!/bin/bash
export PYTHONWARNINGS=ignore::DeprecationWarning
export PYTHONWARNINGS=ignore::RuntimeWarning:runpy
mkdir -p results
pabot --processes 2 --outputdir . --quiet --console none GUI/suite/ API/suite/
mv pabot_results/ results/
mv .pabotsuitenames results/
