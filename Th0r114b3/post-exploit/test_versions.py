import os, subprocess

is_first = True

for subdir, dirs, files in os.walk("kernel_caches"):
    for f in files:
        if f.startswith("kernelcache_"):
            if not is_first:
                print("----------------")
            is_first = False
            version = f[len("kernelcache_"):]
            out = subprocess.check_output([os.path.join(".", "bin", "patchfinder64"), os.path.join("kernel_caches", f)]).strip().split("\n")
            fails = []
            for test in out:
                components = test.split(" - ")
                if components[-1] == "FAIL":
                    fails.append(test)
            if len(fails) > 0:
                print("iOS {} - FAILED".format(version))
                print("\n".join(fails))
            else:
                print("iOS {} - PASSED".format(version))
