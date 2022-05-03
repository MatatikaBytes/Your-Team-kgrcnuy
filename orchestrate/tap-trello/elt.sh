meltano install extractor "$EXTRACTOR"
meltano install loader "$LOADER"
meltano install transform "$EXTRACTOR"
meltano install transformer dbt

# Temporary fix for markdown dependencies issue: https://github.com/dbt-labs/dbt-core/issues/4745
.meltano/transformers/dbt/venv/bin/pip3 install --force-reinstall MarkupSafe==2.0.1


# install dbt deps
meltano invoke dbt deps

# run elt
meltano elt "$EXTRACTOR" "$LOADER"

# dbt
meltano invoke dbt snapshot --select tap_trello
meltano invoke dbt run -m tap_trello --full-refresh