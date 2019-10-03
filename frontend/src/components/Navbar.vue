<template>
  <nav class="navbar is-info">
    <div id="navbarExampleTransparentExample" class="navbar-menu">
      <div class="navbar-start">
        <a class="navbar-item" @click="onHomeButtonClicked">Accueil</a>
        <a class="navbar-item">Demandes</a>
        <a class="navbar-item">Evènements</a>
        <a class="navbar-item">Mes évènements</a>
      </div>

      <div class="navbar-end">
        <div class="navbar-item">
          <div class="field is-grouped">
            <p class="control">
              <a class="bd-tw-button button">Profile</a>
            </p>
            <p class="control">
              <a class="button is-success">Se déconnecter</a>
            </p>
          </div>
        </div>
      </div>
    </div>
  </nav>
</template>

<script>
export default {
  name: "Navbar",
  methods: {
    onHomeButtonClicked() {
      this.$router.push({ path: "/" });
    }
  },
  computed: {
    menu() {
      return this.$store.state.menu;
    }
  }
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
#menu {
  margin: auto;
}
</style>
