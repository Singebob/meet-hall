export type Config = {
  port: number;
  playground?: boolean;
  introspection?: boolean;
  adminToken?: string;
};

const envVariablesList = [
  { name: "PORT", type: Number, optional: false },
  { name: "PLAYGROUND", type: Boolean, optional: true },
  { name: "INTROSPECTION", type: Boolean, optional: true },
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
