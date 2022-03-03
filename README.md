# aws-redshift-access
Grants an application access to a newly-created Redshift database managed by AWS

### Secrets

- `REDSHIFT_PASSWORD`
- `REDSHIFT_URL`

### Env Vars

- `REDSHIFT_USER`
- `REDSHIFT_DB`

### Security Group Rules

- `tcp:5439` <=> `redshift` connection
