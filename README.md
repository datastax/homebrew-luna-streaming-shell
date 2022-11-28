# Luna Streaming Shell

## Getting started

![pulsar-shell-installer](https://user-images.githubusercontent.com/23314389/204251925-c065b0a6-ed40-458e-bc54-760ffb5d7569.gif)


```
curl -Ls "https://raw.githubusercontent.com/datastax/homebrew-luna-streaming-shell/master/get-pulsar-shell.sh" | bash
```

## Getting started with brew (MacOS)

You can install the latest Luna Streaming shell using:

```
brew install datastax/luna-streaming-shell/pulsar-shell
pulsar-shell
```

or

```
brew tap datastax/luna-streaming-shell && brew install pulsar-shell
pulsar-shell
```

The current Luna Streaming version is:
https://github.com/datastax/homebrew-luna-streaming-shell/blob/9be604a85d904e82bee7d7e4c0e62af3f7ac4a6e/pulsar-shell.rb#L4



## Connect to your cluster

Download the `client.conf` from a local file, a remote server or write it inline:
```
pulsar-shell

default(localhost)> config create mycluster --file $local_file

default(localhost)> config create mycluster --url https://url

default(localhost)> config create mycluster --value "
dquote> webServiceUrl=https://admin-url:8443
dquote> brokerServiceUrl=pulsar://service-url:6651
dquote> authPlugin=org.apache.pulsar.client.impl.auth.AuthenticationToken
dquote> authParams=token:xxx
dquote> "
```

or without using the interactive mode:

```
echo '
config create mycluster --value 'webServiceUrl=https://admin-url:8443\nbrokerServiceUrl=pulsar://service-url:6651\nauthPlugin=org.apache.pulsar.client.impl.auth.AuthenticationToken\nauthParams=token:xxx\n'
config view mycluster
config use mycluster
' | pulsar-shell --fail-on-error -
pulsar-shell
```
## Changelog

You can check the Datastax Luna Streaming [changelog](https://github.com/datastax/release-notes/blob/master/Luna_Streaming_2.10_Release_Notes.md) to see what's new.  


# Resources
Visit [Apache Pulsar Shell documentation](https://pulsar.apache.org/docs/next/administration-pulsar-shell/) for more details.
