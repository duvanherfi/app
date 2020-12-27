<template>
  <b-navbar>
    <template slot="brand">
      <b-navbar-item :to="{ path: '/' }">
        <span>
        <i class="fas fa-apple-alt"></i>
        App
        </span>
      </b-navbar-item>
    </template>
    <template slot="start">
      <b-navbar-item href="/">
        Inicio
      </b-navbar-item>
      <b-navbar-item href="#">
        Productos
      </b-navbar-item>
      <b-navbar-dropdown label="Info">
        <b-navbar-item href="#">
          About
        </b-navbar-item>
        <b-navbar-item href="#">
          Contact
        </b-navbar-item>
      </b-navbar-dropdown>
    </template>

    <template slot="end">
      <b-navbar-item tag="div">
        <div class="buttons">
          <a class="button is-primary">
            <strong>Sign up</strong>
          </a>
          <a class="button is-light">
            Log in
          </a>
        </div>
      </b-navbar-item>
    </template>
  </b-navbar>
</template>