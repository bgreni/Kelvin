
import os
import subprocess
import concurrent.futures

def run_test(path):
    ret = subprocess.run(f"mojo -D ASSERT=all -I . {path}", shell=True, capture_output=True, text=True)
    return path, ret

if __name__ == '__main__':
    test_dir = 'test/kelvin'
    paths = [os.path.join(test_dir, file) for file in os.listdir(test_dir)]
    failed = []
    
    # Run tests in parallel
    # Limit workers to avoid resource contention (mojo compilation is heavy).
    # Using a conservative number (4) often yields better throughput than cpu_count() for heavy tasks.
    max_workers = min(os.cpu_count() or 1, 4)
    with concurrent.futures.ThreadPoolExecutor(max_workers=max_workers) as executor:
        # map ensures results are returned in the order of submission (matching original order)
        results = executor.map(run_test, paths)
        
        for p, ret in results:
            if ret.returncode or "FAIL" in ret.stdout:
                failed.append(p)

            if ret.returncode:
                print(ret.stderr)
            else:
                print(ret.stdout)

    if len(failed) != 0:
        print("Failed tests", *failed, sep="\n")
        exit(1)
                

