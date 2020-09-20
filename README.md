# AWS-SAM GitHub Actions

AWS-SAM GitHub Actions allow you to run `sam build` and `sam deploy` and etc.

## Example usage
### Build and deploy on push

```yaml
on: [push]

jobs:
  aws_sam:
    runs-on: ubuntu-latest
    steps:

      - name: Checkout
        uses: actions/checkout@master

      - name: sam build
        uses: youyo/aws-sam-action/python3.8@v2
        with:
          sam_command: build
        env:
          AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
          AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
          AWS_DEFAULT_REGION: ap-northeast-1

      - name: sam deploy
        uses: youyo/aws-sam-action/python3.8@v2
        with:
          sam_command: 'deploy --no-fail-on-empty-changeset --no-confirm-changeset'
        env:
          AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
          AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
          AWS_DEFAULT_REGION: ap-northeast-1
```

### Validate template on pull request
```yaml
on:
  pull_request:
    branches: [master]

jobs:
  aws_sam_validate:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@master

      - name: sam validate
        uses: youyo/aws-sam-action/python3.8@v2
        with:
          sam_command: validate
          actions_comment: true
        env:
          AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
          AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
          AWS_DEFAULT_REGION: 'ap-northeast-1'
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```

### Can I take a assume-role?

If you use assume-role, we recommended using awscredswrap!  
See: https://github.com/marketplace/actions/aws-assume-role-github-actions#use-as-github-actions

```yaml
on: [push]

jobs:
  aws_sam:
    runs-on: ubuntu-latest
    steps:
      - name: Assume Role
        uses: youyo/awscredswrap@master
        with:
          role_arn: ${{ secrets.ROLE_ARN }}
          duration_seconds: 3600
          role_session_name: 'awscredswrap@GitHubActions'
        env:
          AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
          AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
          AWS_DEFAULT_REGION: 'ap-northeast-1'

      - name: Checkout
        uses: actions/checkout@master

      - name: sam build
        uses: youyo/aws-sam-action/python3.8@v2
        with:
          sam_command: build

      - name: sam deploy
        uses: youyo/aws-sam-action/python3.8@v2
        with:
          sam_command: 'deploy --no-fail-on-empty-changeset --no-confirm-changeset'
```

## Supported build language

| Language | Syntax |
| --- | --- |
| python3.8 | youyo/aws-sam-action/python3.8@v2 |
| python3.7 | youyo/aws-sam-action/python3.7@v2 |
| python3.6 | youyo/aws-sam-action/python3.6@v2 |
| nodejs12.x | lfantone/aws-sam-action/nodejs-current@v2 |

## Inputs

- `sam_command` **Required** AWS SAM subcommand to execute.
- `sam_version` AWS SAM version to install. (default: 'latest')
- `actions_comment` Whether or not to comment on pull requests. (default: false)
  - If `true`, the `GITHUB_TOKEN` environment variable should be defined.

## ENV

- `AWS_ACCESS_KEY_ID` **Required**
- `AWS_SECRET_ACCESS_KEY` **Required**
- `GITHUB_TOKEN`

Recommended to get `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` from secrets.

## License

[MIT](LICENSE)

## Author

[youyo](https://github.com/youyo)
