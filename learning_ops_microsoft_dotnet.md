---
path: /learnings/operations_microsoft
title: 'Learnings: Operations: Microsoft dotNET applications'
---
# Table Of Contents

<!-- toc -->

<!-- tocstop -->

# Support / LTS Policies

[.NET Support Policies](https://dotnet.microsoft.com/en-us/platform/support/policy)

LTS (Long Term Support) releases are 3 years of support

STS (Standard Term Support) releases are 18 months of support

_Huh thing about STS releases is there doesn't seem to be a garentee that one will be released in suitable time to adopt it before the previous one goes out of support..._

# Packaging your application for use

Considerations you need to make when building your application

## And Older Libraries

> The .NET Runtime supports loading libraries that target older .NET Runtime versions.
[Source](https://learn.microsoft.com/en-us/dotnet/core/versions/#net-runtime-compatibility)

(So you don't _have_ to upgrade all libraries when doing a .net version upgrade, but probably _should_)

## Multi OS builds

[RuntimeIdentifier](https://learn.microsoft.com/en-us/dotnet/core/rid-catalog) are used to identify target platforms where the application runs.

Can specify multiple runtime identifiers by comma seperated list.

They are not required: the default is to have a framework dependent application. See below

[Summary list of common RuntimeIdentifiers](https://learn.microsoft.com/en-us/dotnet/core/rid-catalog#known-rids)


## Self Contained Applications

>  The output publishing folder contains all components of the app, including the .NET libraries and target runtime. The app is isolated from other .NET apps and doesn't use a locally installed shared runtime. The user of your app isn't required to download and install .NET.
[Source](https://learn.microsoft.com/en-us/dotnet/core/deploying/#publish-self-contained)

You can **specify self contained** or not by setting `SelfContained` in your project file.

Advantage:
  * You control the .NET version - even down to the patch version - and don't require that particular .NET version (or .NET at all installed) on the target machine(s)

Disadvantage:
  * In an enterprise environment if you let something (or some Docker base image) update the ie patch level versions of the .NET update, with self contained _you_ need to rebuild your app.

> By default, dotnet publish for a self-contained deployment selects the latest version installed as part of the SDK on the publishing machine. .....  Self-contained applications are created by specifying -r <RID> on the dotnet publish command or by specifying the runtime identifier (RID) in the project file (csproj / vbproj) or on the command line. [EDIT: AND SelfContained, if .NET >= 8]

[Source: Self-contained deployment runtime roll forward](https://learn.microsoft.com/en-us/dotnet/core/deploying/runtime-patch-selection)

You can **specify the exact library version to use**, vs the default of "the latest version on the publishing machine," by using the `RuntimeFrameworkVersion` property to specify the exact SDK version to build under / include.


### Self Contained and Single Binary

Self contained does NOT mean in a single binary! It'll spew out the libraries and dlls you need though

If you want a [single binary file you need to use PublishSingleFile](https://learn.microsoft.com/en-us/dotnet/core/deploying/single-file/overview)

### Framework Dependent + Cross Platform builds

This combination will create .dlls which will _run on all the platforms_ and platform specific runnable applications.

(if a library does have platform specific dependencies or artifacts they would be stored in publish/runtimes/$platform)

### .NET 8 changes to defaults

In .NET < 8 if you [specified a RuntimeIdentifier you were defaulted into being self-contained application](https://learn.microsoft.com/en-us/dotnet/core/compatibility/sdk/8.0/runtimespecific-app-default).

In .NET 8 you must opt into self contained (not is the default)


## The opposite of self contained (framework dependent)

> Publishing your app as framework-dependent produces an application that includes only your application itself and its dependencies. Users of the application have to separately install the .NET runtime.
[Source](https://learn.microsoft.com/en-us/dotnet/core/deploying/)

Only the app and third party dependencies are included in the resulting binary(s)

### framework dependent builds vs library version installed on the machine

See [Framework Dependent apps roll-forward](https://learn.microsoft.com/en-us/dotnet/core/versions/selection#framework-dependent-apps-roll-forward)

Default behaviors:
  * same major/minor but newer patch installed? FINE, RUN IT
  * same major but newer MINOR installed? FINE, RUN IT ("minor version roll-forward")
  * OLDER **major** version installed? Error message displayed
  * NEWER **major** version installed? Error message displayed

Controlling the behavior:
  * use the `RollForward` property. [Values](https://learn.microsoft.com/en-us/dotnet/core/versions/selection#values)
(including rolling forward _major_ versions, or disabling this behavior entirely)

## See also

  * [.NET application publishing overview](https://learn.microsoft.com/en-us/dotnet/core/deploying/)
