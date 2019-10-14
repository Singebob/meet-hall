<template>
  <div class="event-list">
    <div class="card" v-for="event in events" :key="event.id">
      <header class="card-header">
        <p class="card-header-title">{{ event.name }}</p>
        <button class="card-header-icon" aria-label="expand" @click="toogleEventShow(event)">
          <span class="icon">
            <i class="fas fa-angle-down" aria-hidden="true"></i>
            <font-awesome-icon icon="angle-down" />
          </span>
        </button>
      </header>
      <div class="card-content" v-if="event.show">
        <div class="content">
          {{ event.description }}
          <br />
          <time>{{ formatDateTime(event.date) }}</time>
          <span> - </span>
          <span>{{ event.city }}</span>
        </div>
      </div>
      <footer class="card-footer" v-if="event.show">
        <a href="#" class="card-footer-item">S'incrire</a>
        <a href="#" class="card-footer-item">Plus d'information</a>
      </footer>
    </div>
  </div>
</template>

<script lang="ts">
import Vue from "vue";
import moment from "moment";
import { Event } from "../types/event";
import { events } from "../mocks/events.mock";

export default Vue.extend({
  name: "event-list",
  components: {},
  data() {
    return {
      events: events
    };
  },
  methods: {
    toogleEventShow(event: Event) {
      event.show = !event.show;
    },
    formatDateTime(dateTime: string) {
        return moment(dateTime).format("dddd, MMMM Do YYYY, h:mm a");
    }
  }
});
</script>