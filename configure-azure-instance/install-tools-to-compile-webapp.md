# Install tools to compile WebApp

```text
> sudo apt install npm
...
> sudo npm install npm@latest -g
...
> sudo npm install -g react-scripts
...
```

Check [https://classic.yarnpkg.com/en/docs/install\#debian-stable](https://classic.yarnpkg.com/en/docs/install#debian-stable), how to install **yarn**.

```text
> curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

> sudo apt update && sudo apt install yarn
> sudo yarn add react
...
> sudo yarn upgrade caniuse-lite browserslist
> sudo yarn add react-dom
```

