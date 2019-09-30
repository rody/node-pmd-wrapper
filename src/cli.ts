#!/usr/bin/env node

import pmd from './pmd';

const [, , ...args] = process.argv;
pmd(args);
