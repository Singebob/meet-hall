<template>
  <div class="events">
    <EventList class="events-container" />
  </div>
</template>

<script lang="ts">
import Vue from "vue";
import EventList from "@/components/EventList.vue";

export default Vue.extend({
  name: "events",
  components: {
    EventList
  }
});
</script>

<style scoped>
.events {
  display: flex;
  flex-direction: column;
  justify-content: center;
}
.events-container {
  margin: auto;
  margin-top: 5em;
  width: 75%;
}
</style>