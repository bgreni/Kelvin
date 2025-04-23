
import os
from subprocess import run, DEVNULL

if __name__ == '__main__':
    path = './test/rejects'

    test_configs = {
        'test_reject_mismatched_units.mojo': ['add', 'sub'],
        'test_reject_mismatched_scale.mojo': ['mul', 'div'],
        'test_reject_scalar_ops.mojo': ['add', 'iadd', 'sub', 'isub']
    }

    print('RUNNING COMPILER REJECTION CASES\n')

    success = True
    for f in os.listdir(path):
        for case in test_configs[f]:
            command = ['mojo', '-D', f'CASE={case}', '-I', '.', f'{path + '/' + f}'] 
            p = run(command, stdout=DEVNULL, stderr=DEVNULL)
            if p.returncode == 0:
                success = False
                print(f'TEST CASE {f}:{case} == FAILED')
            else:
                print(f'TEST CASE {f}:{case} == PASSED')
    print('\n\n')
    exit(0 if success else 1)
