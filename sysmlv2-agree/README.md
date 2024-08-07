
# AGREE for SysMLv2 extension

---

## Setup from binaries

1. Install the [SysIDE CE](https://marketplace.visualstudio.com/items?itemName=sensmetry.sysml-2ls) extension from the VSCode marketplace
2. Install Agree with CLI into an OSATE distribution.
3. Open VSCode, click on the extension tab, click the overflow menu button, and select "Intall from VSIX" ![Screenshot showing where to find the "Install from VSIX" menu option](ExtensionInstall.png)
4. Go into settings and enter `Collins.sysml-agree` into the `syside.client.extensions` list. ![Screenshot showing where to find the SysIDE client extensions setting](SysIDE-Settings.png)
5. The extension should be ready to use. Open a folder containing SysMLv2 models written using the AADL base class and follow the setup prompts. SysIDE will offer to download the SysMLv2 base libraries if you do not have them, and they will be stored in `$HOME/.sysml-2ls`. The translator JAR is in the bin folder

## Build instructions

### Modified SysML2AADL translator

1. Follow the instructions to [install the SysMLv2 Pilot Implementation development environment](https://github.com/Systems-Modeling/SysML-v2-Pilot-Implementation)
2. When the installation is complete, switch to the Java perspective and close all of the Jupyter-related projects
    - jupyter-sysml-kernel
    - org.omg.sysml.interactive
    - org.omg.sysml.interactive.tests
    - org.omg.sysml.jupyter.installer
    - org.omg.sysml.jupyter.jupyterlab
3. Go to Help > Install New Software.
4. Paste `https://osate-build.sei.cmu.edu/download/osate/stable/2.14.0/updates` into the Work with box, hit enter, then select "OSATE2 for AADL2" and "Uncategorized". Procede with the installation process, and make sure to trust everything.
5. Click on Window > Preferences and in the Preferences window, select Plug-in Development > Target Platform. Switch to the Running Platform option. Click Apply & close
    - **_NOTE:_** I tried adding these plugins to the Target Platform for SysMLv2, but it did not work.
6. Go to File > Import and choose to import a project from Git. Select "Clone from URI". In the URI box, enter `https://github.com/bathompson/aadl-sysmlv2-annex.git`. Click through to the end of the prompts, leaving everything as default.
7. Find the org.osate.sysml.importer project in the project viewer, right click it, and select export
8. In the export menu, select "Runnable JAR file"
9. In the export dialog:
    - Set the launch configuration as "SysML2AADLUtil
    - Select a directory and name for the JAR file (e.g., SysML2AADL)
    - Select "Package required libraries into generated JAR"
10. Click finish, and accept all dialog pop-ups. It will finish with warnings, but they should not cause any problems.

### Agree for SysMLv2 extension/modified SysIDE languge server

1. Install [PNPM](https://pnpm.io/installation)
    - If NodeJS is installed on your system, simply run `npm install -g pnpm`
2. Navigate to [the syside-for-agree directory](src/syside-for-agree/) and run `pnpm install`. This will build all subprojects.
    -To build an individual project, navigate to the root of the project and run `pnpm run esbuild` for the AGREE extension, or `pnpm run build` for the rest of the projects
3. To run the extension, open [the syside-for-agree directory](src/syside-for-agree/) as the workspace directory in VSCode, go to the `run and debug` menu, select the `Run agree extension` option, and press `F5`
    - If you open the terminal in VSCode (`` ctrl+` ``), click the arrow next to the `+` icon, click `Run Tasks` and run the `AGREE extension watch` task, any modifications made to the agree extension will be detected and automatically recompiled on save.
4. To package the extension, from [the sysml-agree directory](src/syside-for-agree/packages/sysml-agree/), run `pnpm run vscode:package`

### Translating the AADL XText Grammar to Langium

1. Follow the instructions to [set up the OSATE development environment](https://osate.org/setup-development.html#install-the-javafx-sdk)
2. In Eclipse, go to Window > Preferences. In the Preferences window, select Plug-in Development > Target Platforms. Select "Modular Target" and click Edit
3. Click add, select "Software Site", and in the "Work with" box, enter `https://typefox.github.io/xtext2langium/download/updates/v0.4.0/`. Press enter and check the box that appears, and click finish.
4. After the target definition finishes updating, find the "org.osate.xtext.aadl2" project in the project explorer, and expand it.
5. Open up META-INF/MANIFEST.MF, click the Dependencies tab, and in the Required Plug-ins pane, click Add, then select the io.typefox.xtext2langium plugin, then click the Add button, then save
6. In the same project, open up the src/org.osate.xtext.aadl2/GenerateAadl2.mwe2 file
7. At the bottom of the "language = XtextGeneratorLanguage" block, add the following lines of code:

```java
fragment = io.typefox.xtext2languim.Xtext2LangiumFragment {
    outputPath= './langium'
}
```

 8. Right click the .mwe2 file and select Run As > MWE2 Workflow. After it's done running, there should be a "langium" folder at the root of the project containing the translated grammar files. These need to be cleaned up to work properly
