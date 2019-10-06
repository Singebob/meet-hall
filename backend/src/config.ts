export type Config = {
  port: number;
  pghost: string;
  pgdatabase: string;
  pgport: number;
  pguser: string;
  pgpassword: string;
  pgschema: string;
  postgraphile_default_role: string;
  postgraphile_data_management_user_name: string;
  postgraphile_data_management_user_password: string;
  postgraphile_full_access_user_name: string;
  postgraphile_full_access_user_password: string;
  dynamic_json?: boolean;
  postgraphile_watch?: boolean;
  graphiql?: boolean;
  adminToken?: string;
};

const envVariablesList = [
  { name: "PORT", type: Number, optional: false },
  { name: "PGHOST", type: String, optional: false },
  { name: "PGDATABASE", type: String, optional: false },
  { name: "PGPORT", type: Number, optional: false },
  { name: "PGUSER", type: String, optional: false },
  { name: "PGPASSWORD", type: String, optional: false },
  { name: "PGSCHEMA", type: String, optional: false },
  { name: "POSTGRAPHILE_DEFAULT_ROLE", type: String, optional: false },
  {
    name: "POSTGRAPHILE_DATA_MANAGEMENT_USER_NAME",
    type: String,
    optional: false
  },
  {
    name: "POSTGRAPHILE_DATA_MANAGEMENT_USER_PASSWORD",
    type: String,
    optional: false
  },
  { name: "POSTGRAPHILE_FULL_ACCESS_USER_NAME", type: String, optional: false },
  {
    name: "POSTGRAPHILE_FULL_ACCESS_USER_PASSWORD",
    type: String,
    optional: false
  },
  { name: "DYNAMIC_JSON", type: Boolean, optional: true },
  { name: "POSTGRAPHILE_WATCH", type: Boolean, optional: true },
  { name: "GRAPHIQL", type: Boolean, optional: true },
  { name: "ADMIN_TOKEN", type: String, optional: true }
];

const buildConfigObject = (): Config => {
  const errors: string[] = [];
  const config: Config = envVariablesList
    .map(row => {
      if (
        !row.optional &&
        (!process.env[row.name] || !row.type(process.env[row.name]))
      ) {
        errors.push(row.name);
      }
      return { [row.name.toLowerCase()]: row.type(process.env[row.name]) };
    })
    .reduce((previous, current) => ({ ...previous, ...current })) as Config;

  if (errors.length > 0) {
    throw new Error(
      `ERROR: env variable(s) [ ${errors.join(", ")} ] has/have not been set`
    );
  }

  return config;
};

export const config = buildConfigObject();
