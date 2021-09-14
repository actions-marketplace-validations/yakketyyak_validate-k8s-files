## Validate Kubernetes files

[GitHub Action](https://github.com/features/actions) to validate **kubernetes config files** and produce output report.

## Input variables

Input | Description | Default value | Required
------------ | ------------- | ------------- | -------------
`files` | The files or directories to validate separated by comma (dir1,file1,dir2). If empty current directory will be used. | . | **true**
`report_name` | The final report name | report | **false**

## Usage

See [action.yaml](https://github.com/yakketyyak/validate-k8s-files/blob/master/action.yaml)

```
name: validate k8s files
on: [push]
jobs:

  build:
    name: Build
    runs-on: ubuntu-latest
    steps:
    - name: validate kubernetes config files
      id: k8s
      uses: yakketyyak/validate-k8s-files@master
      with:
        files: file1,dir1,dir2,file2
        report_name: My final report
    - uses: actions/upload-artifact@main
      with:
        name: ${{ steps.k8s.outputs.report }}
        path: ${{ steps.k8s.outputs.report }}
```
## License

The scripts and documentation in this project are released under the [Apache License 2.0](https://github.com/yakketyyak/validate-k8s-files/blob/master/LICENSE)
