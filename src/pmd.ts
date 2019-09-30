import findJavaHome from 'find-java-home';
import { spawn } from 'child_process';
import path from 'path';

const findJavaHomeAsync = async (): Promise<string> => {
  return new Promise<string>((resolve, reject): void => {
    findJavaHome({ allowJre: true }, (err, res) => {
      if (err) {
        return reject(err);
      }
      return resolve(res);
    });
  });
};

const pmd = async (args?: string[]): Promise<number> => {
  const javaHome = await findJavaHomeAsync();

  const vendorDir = path.resolve(__dirname, '..', 'vendor');
  const pmdClassPath = path.join(vendorDir, 'pmd', 'lib', '*');
  const pmdCmd = spawn(
    path.join(javaHome, 'bin', 'java'),
    ['-cp', pmdClassPath, 'net.sourceforge.pmd.PMD'].concat(args || []),
  );
  pmdCmd.stderr.pipe(process.stderr);
  pmdCmd.stdout.pipe(process.stdout);

  return new Promise<number>((resolve, reject): void => {
    pmdCmd.on('error', err => {
      reject(err);
    });
    pmdCmd.on('close', code => {
      return resolve(code);
    });
    pmdCmd.on('exit', code => {
      if (code === null || code === undefined) {
        code = 127;
      }
      return resolve(code);
    });
  });
};

export default pmd;
