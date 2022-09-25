slack-logs-ingest-bigquery
==========================

How To Use
----------

1. Visit https://my.slack.com/services/export to [export workspace data](https://slack.com/help/articles/201658943-Export-your-workspace-data) (Slack team admin only) and save zip file.
2. Put the zip file at `./data` directory.
3. Create `config/_out.yml.liquid` from `config/_out.yml.liquid.example`.
4. Preview run by `docker compose up`.
5. Run by `docker compose run --rm embulk bash -c 'embulk run /config/embulk.yml.liquid'`
