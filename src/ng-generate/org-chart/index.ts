import { chain, Rule, noop, Tree, applyToSubtree } from '@angular-devkit/schematics';
import {
  addModuleImportToModule,
  buildComponent,
  findModuleFromOptions,
} from '@angular/cdk/schematics';

import * as figlet from 'figlet';

import { Schema } from './schema';

/**
 * Scaffolds a new org chart component.
 * Internally it bootstraps the base component schematic
 */
export default function(options: Schema): Rule {
  console.log(`\n${figlet.textSync('ng g org chart')}\n`);
  const rules: Rule[] = [
    buildComponent({ ...options }),
    options['skipImport'] ? noop() : addComponentModulesToModule(options)
  ];

  const wd = options.workingDirectory;
  return wd ? applyToSubtree(wd, rules) : chain(rules);
}

/**
 * Adds the required modules to the relative module.
 */
function addComponentModulesToModule(options: Schema) {
  return (host: Tree) => {
    const modulePath = findModuleFromOptions(host, options) || null;
    if (modulePath) {
      addModuleImportToModule(host, modulePath, 'OrganizationChartModule', 'primeng/organizationchart');
      addModuleImportToModule(host, modulePath, 'GrowlModule', 'primeng/growl');
    }
    return host;
  };
}
