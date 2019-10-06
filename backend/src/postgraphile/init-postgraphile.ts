import PgSimplifyInflectorPlugin from "@graphile-contrib/pg-simplify-inflector";
import { config, Config } from "../config";
import { pgPool } from "./init-pgpool";

const computeConnectionString = (config: Config) =>
  `postgres://${config.pguser}:${config.pgpassword}@${config.pghost}:${config.pgport}/${config.pgdatabase}`;

// Our database URL - privileged
const ownerConnection = computeConnectionString(config);
// Our database URL - unprivileged
const connection = pgPool;
// The PostgreSQL schema within our postgres DB to expose
const schema = config.pgschema;
// Enable GraphiQL interface
const graphiql = config.graphiql;
// Send back JSON objects rather than JSON strings
const dynamicJson = config.dynamic_json || true;
// Watch the database for changes
const watch = config.postgraphile_watch || true;
// Define default role of unidentified user
const defaultRole = config.postgraphile_default_role;
// Add some Graphile-Build plugins to enhance our GraphQL schema
const appendPlugins = [
  // Removes the 'ByFooIdAndBarId' from the end of relations
  PgSimplifyInflectorPlugin
];

export const initPostgraphile = () => ({
  // Config for the library (middleware):
  library: {
    connection,
    schema,
    options: {
      ownerConnectionString: ownerConnection,
      dynamicJson,
      graphiql,
      watchPg: watch,
      appendPlugins
    }
  },
  // Options for the CLI:
  options: {
    ownerConnection,
    defaultRole,
    connection,
    schema,
    dynamicJson,
    disableGraphiql: !graphiql,
    enhanceGraphiql: true,
    ignoreRbac: false,
    // We don't set a watch mode here, because there's no way to turn it off (e.g. when using -X) currently.
    appendPlugins
  }
});
