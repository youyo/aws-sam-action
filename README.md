# AWS-SAM GitHub Actions

AWS-SAM GitHub Actions allow you to run `sam build` and `sam deploy` and etc.

## Example usage

```yaml
on: [push]

jobs:
  aws_sam:
    runs-on: ubuntu-latest
    steps:

      - name: sam build
        uses: youyo/aws-sam-action@master
        with:
          sam_subcommand: 'build'
        env:
          AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
          AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
          AWS_DEFAULT_REGION: 'ap-northeast-1'

      - name: sam deploy
        uses: youyo/aws-sam-action@master
        with:
          sam_subcommand: 'deploy'
          args: '--parameter-overrides ParameterKey=KeyPairName,ParameterValue=MyKey'
        env:
          AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
          AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
          AWS_DEFAULT_REGION: 'ap-northeast-1'
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

      - name: sam build
        uses: youyo/aws-sam-action@master
        with:
          sam_subcommand: 'build'

      - name: sam deploy
        uses: youyo/aws-sam-action@master
        with:
          sam_subcommand: 'deploy'
```

## Inputs

- `sam_subcommand` **Required** AWS SAM subcommand to execute.
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
