
# AGREE for SysMLv2 extension

---

## Setup from binaries

1. Install the [SysIDE CE](https://marketplace.visualstudio.com/items?itemName=sensmetry.sysml-2ls) extension from the VSCode marketplace
2. Install Agree with CLI into an OSATE distribution.
3. Open VSCode, click on the extension tab, click the overflow menu button, and select "Intall from VSIX" ![Screenshot showing where to find the "Install from VSIX" menu option](ExtensionInstall.png)
4. Go into settings and enter `Collins.sysml-agree` into the `syside.client.extensions` list. ![Screenshot showing where to find the SysIDE client extensions setting](SysIDE-Settings.png)
5. The extension should be ready to use. Open a folder containing SysMLv2 models written using the AADL base class and follow the setup prompts. SysIDE will offer to download the SysMLv2 base libraries if you do not have them, and they will be stored in `$HOME/.sysml-2ls`. The translator JAR is in the bin folder

## Build instructions

### Agree for SysMLv2 extension/modified SysIDE languge server

1. Install [PNPM](https://pnpm.io/installation)
2. Navigate to [the sysml-2ls directory](src/sysml-2ls/) and run `pnpm install`. This will build all subprojects.
    -To build an individual project, navigate to the root of the project and run `pnpm run esbuild` for the AGREE extension, or `pnpm run build` for the rest of the projects
3. To run the extension, open [the sysml-2ls directory](src/sysml-2ls/) as the workspace directory in VSCode, go to the `run and debug` menu, select the `Run agree extension` option, and press `F5`
    - If you open the terminal in VSCode (`` ctrl+` ``), click the arrow next to the `+` icon, click `Run Tasks` and run the `AGREE extension watch` task, any modifications made to the agree extension will be detected and automatically recompiled on save.
4. To package the extension, from [the sysml-agree directory](src/sysml-2ls/packages/sysml-agree/), run `pnpm run vscode:package`
