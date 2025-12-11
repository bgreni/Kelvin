
import os
from subprocess import run, DEVNULL

import concurrent.futures

def run_case(f, case, path):
    command = ['mojo', '-D', f'CASE={case}', '-I', '.', f'{path + '/' + f}'] 
    p = run(command, stdout=DEVNULL, stderr=DEVNULL)
    return f, case, p.returncode

if __name__ == '__main__':
    path = './test/rejects'

    test_configs = {
        'test_reject_mismatched_units.mojo': ['add', 'sub'],
        'test_reject_mismatched_scale.mojo': ['mul', 'div'],
        'test_reject_scalar_ops.mojo': ['add', 'iadd', 'sub', 'isub'],
        'test_reject_mismatched_vec_size.mojo': ['']
    }

    print('RUNNING COMPILER REJECTION CASES\n')

    all_cases = []
    for f in os.listdir(path):
        if f in test_configs:
            for case in test_configs[f]:
                all_cases.append((f, case))

    success = True
    max_workers = min(os.cpu_count() or 1, 4)
    with concurrent.futures.ThreadPoolExecutor(max_workers=max_workers) as executor:
        futures = {executor.submit(run_case, f, case, path): (f, case) for f, case in all_cases}
        
        for future in concurrent.futures.as_completed(futures):
            f, case = futures[future]
            try:
                _, _, returncode = future.result()
                if returncode == 0:
                    success = False
                    print(f'TEST CASE {f}:{case} == FAILED')
                else:
                    print(f'TEST CASE {f}:{case} == PASSED')
            except Exception as exc:
                success = False
                print(f'TEST CASE {f}:{case} generated an exception: {exc}')

    print('\n\n')
    exit(0 if success else 1)
