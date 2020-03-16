# Installing JDK

### Install JDK

```bash
$ sudo yum install java-11-amazon-corretto.x86_64
```

```text
Loaded plugins: extras_suggestions, langpacks, priorities, update-motd
amzn2-core                                               | 2.4 kB     00:00     
amzn2extra-docker                                        | 1.3 kB     00:00     
Resolving Dependencies
--> Running transaction check
---> Package java-11-amazon-corretto.x86_64 1:11.0.4+11-1.amzn2 will be installed
--> Processing Dependency: java-11-amazon-corretto-headless(x86-64) = 1:11.0.4+11-1.amzn2 for package: 1:java-11-amazon-corretto-11.0.4+11-1.amzn2.x86_64
--> Processing Dependency: dejavu-sans-mono-fonts for package: 1:java-11-amazon-corretto-11.0.4+11-1.amzn2.x86_64
--> Processing Dependency: dejavu-serif-fonts for package: 1:java-11-amazon-corretto-11.0.4+11-1.amzn2.x86_64
--> Processing Dependency: dejavu-sans-fonts for package: 1:java-11-amazon-corretto-11.0.4+11-1.amzn2.x86_64
--> Processing Dependency: libpng for package: 1:java-11-amazon-corretto-11.0.4+11-1.amzn2.x86_64
--> Processing Dependency: giflib for package: 1:java-11-amazon-corretto-11.0.4+11-1.amzn2.x86_64
--> Processing Dependency: alsa-lib for package: 1:java-11-amazon-corretto-11.0.4+11-1.amzn2.x86_64
--> Processing Dependency: libXtst for package: 1:java-11-amazon-corretto-11.0.4+11-1.amzn2.x86_64
--> Processing Dependency: libXrandr for package: 1:java-11-amazon-corretto-11.0.4+11-1.amzn2.x86_64
--> Processing Dependency: libXrender for package: 1:java-11-amazon-corretto-11.0.4+11-1.amzn2.x86_64
--> Processing Dependency: libXt for package: 1:java-11-amazon-corretto-11.0.4+11-1.amzn2.x86_64
--> Processing Dependency: libXinerama for package: 1:java-11-amazon-corretto-11.0.4+11-1.amzn2.x86_64
--> Processing Dependency: libXi for package: 1:java-11-amazon-corretto-11.0.4+11-1.amzn2.x86_64
--> Processing Dependency: libX11 for package: 1:java-11-amazon-corretto-11.0.4+11-1.amzn2.x86_64
--> Running transaction check
---> Package alsa-lib.x86_64 0:1.1.4.1-2.amzn2 will be installed
---> Package dejavu-sans-fonts.noarch 0:2.33-6.amzn2 will be installed
--> Processing Dependency: dejavu-fonts-common = 2.33-6.amzn2 for package: dejavu-sans-fonts-2.33-6.amzn2.noarch
---> Package dejavu-sans-mono-fonts.noarch 0:2.33-6.amzn2 will be installed
---> Package dejavu-serif-fonts.noarch 0:2.33-6.amzn2 will be installed
---> Package giflib.x86_64 0:4.1.6-9.amzn2.0.2 will be installed
--> Processing Dependency: libSM.so.6()(64bit) for package: giflib-4.1.6-9.amzn2.0.2.x86_64
--> Processing Dependency: libICE.so.6()(64bit) for package: giflib-4.1.6-9.amzn2.0.2.x86_64
---> Package java-11-amazon-corretto-headless.x86_64 1:11.0.4+11-1.amzn2 will be installed
--> Processing Dependency: fontconfig for package: 1:java-11-amazon-corretto-headless-11.0.4+11-1.amzn2.x86_64
--> Processing Dependency: jpackage-utils for package: 1:java-11-amazon-corretto-headless-11.0.4+11-1.amzn2.x86_64
---> Package libX11.x86_64 0:1.6.5-2.amzn2.0.2 will be installed
--> Processing Dependency: libX11-common >= 1.6.5-2.amzn2.0.2 for package: libX11-1.6.5-2.amzn2.0.2.x86_64
--> Processing Dependency: libxcb.so.1()(64bit) for package: libX11-1.6.5-2.amzn2.0.2.x86_64
---> Package libXi.x86_64 0:1.7.9-1.amzn2.0.2 will be installed
--> Processing Dependency: libXext.so.6()(64bit) for package: libXi-1.7.9-1.amzn2.0.2.x86_64
---> Package libXinerama.x86_64 0:1.1.3-2.1.amzn2.0.2 will be installed
---> Package libXrandr.x86_64 0:1.5.1-2.amzn2.0.2 will be installed
---> Package libXrender.x86_64 0:0.9.10-1.amzn2.0.2 will be installed
---> Package libXt.x86_64 0:1.1.5-3.amzn2.0.2 will be installed
---> Package libXtst.x86_64 0:1.2.3-1.amzn2.0.2 will be installed
---> Package libpng.x86_64 2:1.5.13-7.amzn2.0.2 will be installed
--> Running transaction check
---> Package dejavu-fonts-common.noarch 0:2.33-6.amzn2 will be installed
--> Processing Dependency: fontpackages-filesystem for package: dejavu-fonts-common-2.33-6.amzn2.noarch
---> Package fontconfig.x86_64 0:2.10.95-11.amzn2.0.2 will be installed
---> Package javapackages-tools.noarch 0:3.4.1-11.amzn2 will be installed
--> Processing Dependency: python-javapackages = 3.4.1-11.amzn2 for package: javapackages-tools-3.4.1-11.amzn2.noarch
--> Processing Dependency: libxslt for package: javapackages-tools-3.4.1-11.amzn2.noarch
---> Package libICE.x86_64 0:1.0.9-9.amzn2.0.2 will be installed
---> Package libSM.x86_64 0:1.2.2-2.amzn2.0.2 will be installed
---> Package libX11-common.noarch 0:1.6.5-2.amzn2.0.2 will be installed
---> Package libXext.x86_64 0:1.3.3-3.amzn2.0.2 will be installed
---> Package libxcb.x86_64 0:1.12-1.amzn2.0.2 will be installed
--> Processing Dependency: libXau.so.6()(64bit) for package: libxcb-1.12-1.amzn2.0.2.x86_64
--> Running transaction check
---> Package fontpackages-filesystem.noarch 0:1.44-8.amzn2 will be installed
---> Package libXau.x86_64 0:1.0.8-2.1.amzn2.0.2 will be installed
---> Package libxslt.x86_64 0:1.1.28-5.amzn2.0.2 will be installed
---> Package python-javapackages.noarch 0:3.4.1-11.amzn2 will be installed
--> Processing Dependency: python-lxml for package: python-javapackages-3.4.1-11.amzn2.noarch
--> Running transaction check
---> Package python-lxml.x86_64 0:3.2.1-4.amzn2.0.2 will be installed
--> Finished Dependency Resolution

Dependencies Resolved

================================================================================
 Package                          Arch   Version               Repository  Size
================================================================================
Installing:
 java-11-amazon-corretto          x86_64 1:11.0.4+11-1.amzn2   amzn2-core 190 k
Installing for dependencies:
 alsa-lib                         x86_64 1.1.4.1-2.amzn2       amzn2-core 425 k
 dejavu-fonts-common              noarch 2.33-6.amzn2          amzn2-core  64 k
 dejavu-sans-fonts                noarch 2.33-6.amzn2          amzn2-core 1.4 M
 dejavu-sans-mono-fonts           noarch 2.33-6.amzn2          amzn2-core 433 k
 dejavu-serif-fonts               noarch 2.33-6.amzn2          amzn2-core 777 k
 fontconfig                       x86_64 2.10.95-11.amzn2.0.2  amzn2-core 231 k
 fontpackages-filesystem          noarch 1.44-8.amzn2          amzn2-core  10 k
 giflib                           x86_64 4.1.6-9.amzn2.0.2     amzn2-core  40 k
 java-11-amazon-corretto-headless x86_64 1:11.0.4+11-1.amzn2   amzn2-core 163 M
 javapackages-tools               noarch 3.4.1-11.amzn2        amzn2-core  73 k
 libICE                           x86_64 1.0.9-9.amzn2.0.2     amzn2-core  67 k
 libSM                            x86_64 1.2.2-2.amzn2.0.2     amzn2-core  39 k
 libX11                           x86_64 1.6.5-2.amzn2.0.2     amzn2-core 614 k
 libX11-common                    noarch 1.6.5-2.amzn2.0.2     amzn2-core 164 k
 libXau                           x86_64 1.0.8-2.1.amzn2.0.2   amzn2-core  29 k
 libXext                          x86_64 1.3.3-3.amzn2.0.2     amzn2-core  39 k
 libXi                            x86_64 1.7.9-1.amzn2.0.2     amzn2-core  41 k
 libXinerama                      x86_64 1.1.3-2.1.amzn2.0.2   amzn2-core  14 k
 libXrandr                        x86_64 1.5.1-2.amzn2.0.2     amzn2-core  27 k
 libXrender                       x86_64 0.9.10-1.amzn2.0.2    amzn2-core  26 k
 libXt                            x86_64 1.1.5-3.amzn2.0.2     amzn2-core 177 k
 libXtst                          x86_64 1.2.3-1.amzn2.0.2     amzn2-core  20 k
 libpng                           x86_64 2:1.5.13-7.amzn2.0.2  amzn2-core 214 k
 libxcb                           x86_64 1.12-1.amzn2.0.2      amzn2-core 216 k
 libxslt                          x86_64 1.1.28-5.amzn2.0.2    amzn2-core 243 k
 python-javapackages              noarch 3.4.1-11.amzn2        amzn2-core  31 k
 python-lxml                      x86_64 3.2.1-4.amzn2.0.2     amzn2-core 1.0 M

Transaction Summary
================================================================================
Install  1 Package (+27 Dependent packages)

Total download size: 169 M
Installed size: 322 M
Is this ok [y/d/N]: y
Downloading packages:
(1/28): dejavu-fonts-common-2.33-6.amzn2.noarch.rpm                                                          |  64 kB  00:00:00     
(2/28): alsa-lib-1.1.4.1-2.amzn2.x86_64.rpm                                                                  | 425 kB  00:00:00     
(3/28): dejavu-sans-mono-fonts-2.33-6.amzn2.noarch.rpm                                                       | 433 kB  00:00:00     
(4/28): dejavu-sans-fonts-2.33-6.amzn2.noarch.rpm                                                            | 1.4 MB  00:00:00     
(5/28): dejavu-serif-fonts-2.33-6.amzn2.noarch.rpm                                                           | 777 kB  00:00:00     
(6/28): fontconfig-2.10.95-11.amzn2.0.2.x86_64.rpm                                                           | 231 kB  00:00:00     
(7/28): fontpackages-filesystem-1.44-8.amzn2.noarch.rpm                                                      |  10 kB  00:00:00     
(8/28): giflib-4.1.6-9.amzn2.0.2.x86_64.rpm                                                                  |  40 kB  00:00:00     
(9/28): java-11-amazon-corretto-11.0.4+11-1.amzn2.x86_64.rpm                                                 | 190 kB  00:00:00     
(10/28): javapackages-tools-3.4.1-11.amzn2.noarch.rpm                                                        |  73 kB  00:00:00     
(11/28): libICE-1.0.9-9.amzn2.0.2.x86_64.rpm                                                                 |  67 kB  00:00:00     
(12/28): libSM-1.2.2-2.amzn2.0.2.x86_64.rpm                                                                  |  39 kB  00:00:00     
(13/28): libX11-1.6.5-2.amzn2.0.2.x86_64.rpm                                                                 | 614 kB  00:00:00     
(14/28): libX11-common-1.6.5-2.amzn2.0.2.noarch.rpm                                                          | 164 kB  00:00:00     
(15/28): libXau-1.0.8-2.1.amzn2.0.2.x86_64.rpm                                                               |  29 kB  00:00:00     
(16/28): libXext-1.3.3-3.amzn2.0.2.x86_64.rpm                                                                |  39 kB  00:00:00     
(17/28): libXi-1.7.9-1.amzn2.0.2.x86_64.rpm                                                                  |  41 kB  00:00:00     
(18/28): libXinerama-1.1.3-2.1.amzn2.0.2.x86_64.rpm                                                          |  14 kB  00:00:00     
(19/28): libXrandr-1.5.1-2.amzn2.0.2.x86_64.rpm                                                              |  27 kB  00:00:00     
(20/28): libXrender-0.9.10-1.amzn2.0.2.x86_64.rpm                                                            |  26 kB  00:00:00     
(21/28): libXt-1.1.5-3.amzn2.0.2.x86_64.rpm                                                                  | 177 kB  00:00:00     
(22/28): libXtst-1.2.3-1.amzn2.0.2.x86_64.rpm                                                                |  20 kB  00:00:00     
(23/28): libpng-1.5.13-7.amzn2.0.2.x86_64.rpm                                                                | 214 kB  00:00:00     
(24/28): libxcb-1.12-1.amzn2.0.2.x86_64.rpm                                                                  | 216 kB  00:00:00     
(25/28): libxslt-1.1.28-5.amzn2.0.2.x86_64.rpm                                                               | 243 kB  00:00:00     
(26/28): python-javapackages-3.4.1-11.amzn2.noarch.rpm                                                       |  31 kB  00:00:00     
(27/28): python-lxml-3.2.1-4.amzn2.0.2.x86_64.rpm                                                            | 1.0 MB  00:00:00     
(28/28): java-11-amazon-corretto-headless-11.0.4+11-1.amzn2.x86_64.rpm                                       | 163 MB  00:00:03     
------------------------------------------------------------------------------------------------------------------------------------
Total                                                                                                52 MB/s | 169 MB  00:00:03     
Running transaction check
Running transaction test
Transaction test succeeded
Running transaction
  Installing : libICE-1.0.9-9.amzn2.0.2.x86_64                                                                                 1/28 
  Installing : libSM-1.2.2-2.amzn2.0.2.x86_64                                                                                  2/28 
  Installing : fontpackages-filesystem-1.44-8.amzn2.noarch                                                                     3/28 
  Installing : dejavu-fonts-common-2.33-6.amzn2.noarch                                                                         4/28 
  Installing : dejavu-serif-fonts-2.33-6.amzn2.noarch                                                                          5/28 
  Installing : libxslt-1.1.28-5.amzn2.0.2.x86_64                                                                               6/28 
  Installing : python-lxml-3.2.1-4.amzn2.0.2.x86_64                                                                            7/28 
  Installing : python-javapackages-3.4.1-11.amzn2.noarch                                                                       8/28 
  Installing : javapackages-tools-3.4.1-11.amzn2.noarch                                                                        9/28 
  Installing : fontconfig-2.10.95-11.amzn2.0.2.x86_64                                                                         10/28 
  Installing : 1:java-11-amazon-corretto-headless-11.0.4+11-1.amzn2.x86_64                                                    11/28 
  Installing : dejavu-sans-mono-fonts-2.33-6.amzn2.noarch                                                                     12/28 
  Installing : dejavu-sans-fonts-2.33-6.amzn2.noarch                                                                          13/28 
  Installing : alsa-lib-1.1.4.1-2.amzn2.x86_64                                                                                14/28 
  Installing : libXau-1.0.8-2.1.amzn2.0.2.x86_64                                                                              15/28 
  Installing : libxcb-1.12-1.amzn2.0.2.x86_64                                                                                 16/28 
  Installing : 2:libpng-1.5.13-7.amzn2.0.2.x86_64                                                                             17/28 
  Installing : libX11-common-1.6.5-2.amzn2.0.2.noarch                                                                         18/28 
  Installing : libX11-1.6.5-2.amzn2.0.2.x86_64                                                                                19/28 
  Installing : libXext-1.3.3-3.amzn2.0.2.x86_64                                                                               20/28 
  Installing : libXi-1.7.9-1.amzn2.0.2.x86_64                                                                                 21/28 
  Installing : libXrender-0.9.10-1.amzn2.0.2.x86_64                                                                           22/28 
  Installing : libXrandr-1.5.1-2.amzn2.0.2.x86_64                                                                             23/28 
  Installing : libXtst-1.2.3-1.amzn2.0.2.x86_64                                                                               24/28 
  Installing : libXinerama-1.1.3-2.1.amzn2.0.2.x86_64                                                                         25/28 
  Installing : libXt-1.1.5-3.amzn2.0.2.x86_64                                                                                 26/28 
  Installing : giflib-4.1.6-9.amzn2.0.2.x86_64                                                                                27/28 
  Installing : 1:java-11-amazon-corretto-11.0.4+11-1.amzn2.x86_64                                                             28/28 
  Verifying  : 1:java-11-amazon-corretto-headless-11.0.4+11-1.amzn2.x86_64                                                     1/28 
  Verifying  : libX11-common-1.6.5-2.amzn2.0.2.noarch                                                                          2/28 
  Verifying  : libxslt-1.1.28-5.amzn2.0.2.x86_64                                                                               3/28 
  Verifying  : dejavu-serif-fonts-2.33-6.amzn2.noarch                                                                          4/28 
  Verifying  : libX11-1.6.5-2.amzn2.0.2.x86_64                                                                                 5/28 
  Verifying  : python-lxml-3.2.1-4.amzn2.0.2.x86_64                                                                            6/28 
  Verifying  : libxcb-1.12-1.amzn2.0.2.x86_64                                                                                  7/28 
  Verifying  : 2:libpng-1.5.13-7.amzn2.0.2.x86_64                                                                              8/28 
  Verifying  : 1:java-11-amazon-corretto-11.0.4+11-1.amzn2.x86_64                                                              9/28 
  Verifying  : dejavu-sans-mono-fonts-2.33-6.amzn2.noarch                                                                     10/28 
  Verifying  : dejavu-fonts-common-2.33-6.amzn2.noarch                                                                        11/28 
  Verifying  : libXau-1.0.8-2.1.amzn2.0.2.x86_64                                                                              12/28 
  Verifying  : libSM-1.2.2-2.amzn2.0.2.x86_64                                                                                 13/28 
  Verifying  : libXrender-0.9.10-1.amzn2.0.2.x86_64                                                                           14/28 
  Verifying  : dejavu-sans-fonts-2.33-6.amzn2.noarch                                                                          15/28 
  Verifying  : libXt-1.1.5-3.amzn2.0.2.x86_64                                                                                 16/28 
  Verifying  : giflib-4.1.6-9.amzn2.0.2.x86_64                                                                                17/28 
  Verifying  : fontconfig-2.10.95-11.amzn2.0.2.x86_64                                                                         18/28 
  Verifying  : libXi-1.7.9-1.amzn2.0.2.x86_64                                                                                 19/28 
  Verifying  : libXext-1.3.3-3.amzn2.0.2.x86_64                                                                               20/28 
  Verifying  : libXinerama-1.1.3-2.1.amzn2.0.2.x86_64                                                                         21/28 
  Verifying  : libXrandr-1.5.1-2.amzn2.0.2.x86_64                                                                             22/28 
  Verifying  : python-javapackages-3.4.1-11.amzn2.noarch                                                                      23/28 
  Verifying  : libXtst-1.2.3-1.amzn2.0.2.x86_64                                                                               24/28 
  Verifying  : alsa-lib-1.1.4.1-2.amzn2.x86_64                                                                                25/28 
  Verifying  : fontpackages-filesystem-1.44-8.amzn2.noarch                                                                    26/28 
  Verifying  : libICE-1.0.9-9.amzn2.0.2.x86_64                                                                                27/28 
  Verifying  : javapackages-tools-3.4.1-11.amzn2.noarch                                                                       28/28 

Installed:
  java-11-amazon-corretto.x86_64 1:11.0.4+11-1.amzn2                                                                                

Dependency Installed:
  alsa-lib.x86_64 0:1.1.4.1-2.amzn2                                        dejavu-fonts-common.noarch 0:2.33-6.amzn2                
  dejavu-sans-fonts.noarch 0:2.33-6.amzn2                                  dejavu-sans-mono-fonts.noarch 0:2.33-6.amzn2             
  dejavu-serif-fonts.noarch 0:2.33-6.amzn2                                 fontconfig.x86_64 0:2.10.95-11.amzn2.0.2                 
  fontpackages-filesystem.noarch 0:1.44-8.amzn2                            giflib.x86_64 0:4.1.6-9.amzn2.0.2                        
  java-11-amazon-corretto-headless.x86_64 1:11.0.4+11-1.amzn2              javapackages-tools.noarch 0:3.4.1-11.amzn2               
  libICE.x86_64 0:1.0.9-9.amzn2.0.2                                        libSM.x86_64 0:1.2.2-2.amzn2.0.2                         
  libX11.x86_64 0:1.6.5-2.amzn2.0.2                                        libX11-common.noarch 0:1.6.5-2.amzn2.0.2                 
  libXau.x86_64 0:1.0.8-2.1.amzn2.0.2                                      libXext.x86_64 0:1.3.3-3.amzn2.0.2                       
  libXi.x86_64 0:1.7.9-1.amzn2.0.2                                         libXinerama.x86_64 0:1.1.3-2.1.amzn2.0.2                 
  libXrandr.x86_64 0:1.5.1-2.amzn2.0.2                                     libXrender.x86_64 0:0.9.10-1.amzn2.0.2                   
  libXt.x86_64 0:1.1.5-3.amzn2.0.2                                         libXtst.x86_64 0:1.2.3-1.amzn2.0.2                       
  libpng.x86_64 2:1.5.13-7.amzn2.0.2                                       libxcb.x86_64 0:1.12-1.amzn2.0.2                         
  libxslt.x86_64 0:1.1.28-5.amzn2.0.2                                      python-javapackages.noarch 0:3.4.1-11.amzn2              
  python-lxml.x86_64 0:3.2.1-4.amzn2.0.2                                  

Complete!
```

**Checking java version**

```bash
$ java -version
openjdk version "11.0.3" 2019-04-16 LTS
OpenJDK Runtime Environment Corretto-11.0.3.7.1 (build 11.0.3+7-LTS)
OpenJDK 64-Bit Server VM Corretto-11.0.3.7.1 (build 11.0.3+7-LTS, mixed mode)
```

```bash
$ javac -version
javac 11.0.3
```

