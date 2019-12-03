# AWS-SAM GitHub Actions

AWS-SAM GitHub Actions allow you to run `sam build` and `sam deploy` and etc.

## Example usage

```yaml
on: [push]

jobs:
  aws_sam:
    runs-on: ubuntu-latest
    steps:

      - name: Checkout
        uses: actions/checkout@master

      - name: sam build
        uses: youyo/aws-sam-action/python3.8@master
        with:
          sam_command: build
        env:
          AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
          AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
          AWS_DEFAULT_REGION: ap-northeast-1

      - name: sam deploy
        uses: youyo/aws-sam-action/python3.8@master
        with:
          sam_command: 'deploy --no-fail-on-empty-changeset'
        env:
          AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
          AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
          AWS_DEFAULT_REGION: ap-northeast-1
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
        uses: youyo/aws-sam-action/python3.8@master
        with:
          sam_command: build

      - name: sam deploy
        uses: youyo/aws-sam-action/python3.8@master
        with:
          sam_command: 'deploy --no-fail-on-empty-changeset'
```

## Supported build language

| Language | Syntax |
| --- | --- |
| python3.8 | youyo/aws-sam-action/python3.8@master |
| python3.7 | youyo/aws-sam-action/python3.7@master |
| python3.6 | youyo/aws-sam-action/python3.6@master |

## Inputs

- `sam_command` **Required** AWS SAM subcommand to execute.
- `sam_version` AWS SAM version to install. (default: 'latest')
- `actions_comment` Whether or not to comment on pull requests. (default: false)

## ENV

- `AWS_ACCESS_KEY_ID` **Required**
- `AWS_SECRET_ACCESS_KEY` **Required**

Recommended to get `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` from secrets.

## License

[MIT](LICENSE)

## Author

[youyo](https://github.com/youyo)
