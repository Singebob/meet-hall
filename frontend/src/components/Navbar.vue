<template>
  <nav class="navbar is-primary">
    <div id="navbarExampleTransparentExample" class="navbar-menu">
      <div class="navbar-start">
        <a class="navbar-item" href="/">Accueil</a>
        <a class="navbar-item" >Demandes</a>
        <a class="navbar-item" href="/events">Evènements</a>
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
  name: "Navbar"
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
.navbar.is-primary .navbar-start > .navbar-item,
.navbar-menu {
  color: #ffffff;
  background-color: #1976d2;
}
.navbar.is-primary .navbar-start > .navbar-item:hover {
  color: #ffffff;
  background-color: #004ba0;
}
</style>
