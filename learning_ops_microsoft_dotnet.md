---
path: /learnings/operations_microservices
title: 'Learnings: Operations: Microservices'
---
# Table Of Contents

<!-- toc -->

<!-- tocstop -->

# Handling multiple or new versions of .NET


# Runtime Identifiers

[RuntimeIdentifier](https://learn.microsoft.com/en-us/dotnet/core/rid-catalog) are used to identify target platforms where the application runs.

Can specify multiple runtime identifiers by comma seperated list.

They are not required: the default is to have a framework dependent application. See below

- [TODO]: now what the f does that mean?

[Summary list of common RuntimeIdentifiers](https://learn.microsoft.com/en-us/dotnet/core/rid-catalog#known-rids)


# Self Contained Applications

> By default, dotnet publish for a self-contained deployment selects the latest version installed as part of the SDK on the publishing machine. .....  Self-contained applications are created by specifying -r <RID> on the dotnet publish command or by specifying the runtime identifier (RID) in the project file (csproj / vbproj) or on the command line. [EDIT: AND SelfContained, if .NET >= 8]

[Source: Self-contained deployment runtime roll forward](https://learn.microsoft.com/en-us/dotnet/core/deploying/runtime-patch-selection)

With .NET 8, if you [specified a RuntimeIdentifier you need to opt into being a self-contained application](https://learn.microsoft.com/en-us/dotnet/core/compatibility/sdk/8.0/runtimespecific-app-default). You can specify self contained or not by setting `SelfContained` in your project file.

Self contained does NOT mean in a single binary! It'll spew out the libraries and dlls you need though

If you want a [single binary file you need to use PublishSingleFile](https://learn.microsoft.com/en-us/dotnet/core/deploying/single-file/overview)

## The opposite of self contained (framework dependent)

> Publishing your app as framework-dependent produces an application that includes only your application itself and its dependencies. Users of the application have to separately install the .NET runtime.
[Source](https://learn.microsoft.com/en-us/dotnet/core/deploying/)

Only the app and third party dependencies are included in the resulting binary(s)

### framework dependent when the specified framework version isn't installed

- [TODO]: write me

# See also

  * [.NET application publishing overview](https://learn.microsoft.com/en-us/dotnet/core/deploying/)
