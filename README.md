# tracker


### compile

```
docker pull csuliuming/gko3-compile-env:v1.0
docker run -ti -name xtorrent csuliuming/gko3-compile-env:v1.0 bash
git clone https://github.com/xtorrent/tracker.git
cd tracker
./build.sh                # generate gko3-tracker.tgz in $PWD/output
```

### run
- start `gko3-tracker` must in `bin/` directory
- start & stop

    ```
    nohup ./gko3-trakcer &        # start
    pkill gko3-tracker            # stop
    ```
