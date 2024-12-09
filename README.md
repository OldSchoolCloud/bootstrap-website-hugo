# bootstrap-website-hugo
A bootstrap repository to create a website powered by [Hugo](https://gohugo.io/).

## 1. Install Hugo
> Docs: https://gohugo.io/installation

### MacOS using `brew`:
> Install [brew](https://brew.sh/):
>
> ```commandline
> /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
> ```
```commandline
brew update
brew install hugo
```

> Check installation:
> ```commandline
> hugo version
> ```
>
> Expected result:
> ```
> hugo v0.139.3+extended+withdeploy darwin/arm64 BuildDate=2024-11-29T15:36:56Z VendorInfo=brew
> ```

## 2. Clone the repository & Git submodules

### Option 1: Clone the repo including the submodules
```commandline
git clone --recurse-submodules git@github.com:OldSchoolCloud/bootstrap-website-hugo.git
```

### Option 2: Clone the repo and install submodules separately
Clone the repo:
```commandline
git clone git@github.com:OldSchoolCloud/bootstrap-website-hugo.git
```

Install submodules:
```commandline
cd bootstrap-website-hugo
git submodule init
git submodule update
```

## 3. Start Hugo’s development server
```commandline
hugo server
```
Or if you want to include drafts in your development build:
```commandline
hugo server -D
```

Press Ctrl + C to stop Hugo’s development server.

## 4. Configuration
> This repository is using the Hugo theme `blowfish` by default.
>
> Docs: https://blowfish.page/docs/configuration/

### Customise the following parameters in `config/_default/`:

[hugo.toml](config/_default/hugo.toml)

```toml
baseURL = "https://oldschoolcloud.com/"
```

[languages.en.toml](config/_default/languages.en.toml)
```toml
title = "OldSchoolCloud"
[params.author]
  name = "Valerio"
  links = [{ instagram = "https://instagram.com/oldschoolcloud" }]
```

[menus.en.toml](config/_default/menus.en.toml) - Add your own menu items ie:
```toml
[[main]]
  name = "Posts"
  pageRef = "posts"
  pre = "pencil"
  weight = 10
```

[params.toml](config/_default/params.toml)
```toml
colorScheme = "blowfish"
editURL = "https://github.com/oldschoolcloud/bootstrap-website-hugo/"
```

## Updating Hugo and the Blowfish theme

### Update Hugo
```commandline
brew update
brew install hugo
```

### Update the Blowfish theme
> Docs: https://blowfish.page/docs/installation/#installing-updates
>
> Releases: https://github.com/nunocoracao/blowfish/releases
```commandline
git submodule update --remote --merge
```

Make sure you rebuild the site to check that all went well:
```commandline
hugo
```
Check the development server:
```commandline
hugo server
```

## Build Docker image

Select your desired [version](https://github.com/gohugoio/hugo/releases) of Hugo, for example 0.139.3:
```commandline
docker build -t bootstrap-website-hugo --build-arg HUGO_VERSION=0.139.3 .
```

After the image is built successfully, you can run a container based on this image:
```commandline
docker run -p 1313:80 bootstrap-website-hugo
```