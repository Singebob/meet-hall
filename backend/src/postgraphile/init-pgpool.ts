import pg from "pg";
import { config, Config } from "../config";

const initPgPool = (config: Config) => new pg.Pool({
  host: config.pghost,
  database: config.pgdatabase,
  port: config.pgport,
  user: config.pguser,
  password: config.pgpassword
});

export const pgPool = initPgPool(config);