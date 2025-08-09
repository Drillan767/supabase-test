<script setup lang="ts">
import type { Session } from '@supabase/supabase-js'
import { ref, onMounted } from 'vue'
import { supabase } from './utils/supabase'

async function signInWithTwitter() {
await supabase.auth.signInWithOAuth({
        provider: 'twitter',
        options: {
            redirectTo: 'http://localhost:5173', // Adjust this URL to your app's callback URL
        },
    })
}

const authSession = ref<Session | null>()

onMounted(async () => {
    // Handle OAuth callback
    const { data, error } = await supabase.auth.getSession()
    if (data.session) {
        authSession.value = data.session
        console.log('User signed in:', data.session.user)
    }
    if (error) {
        console.error('Error fetching session:', error.message)
    }
    supabase.auth.onAuthStateChange((event, session) => {
        if (event === 'SIGNED_IN') {
            authSession.value = session
            console.log('User signed in:', session?.user)
        }
    })
})
</script>

<template>
  <div class="app">
    <h1>Welcome to the App</h1>
    <button @click="signInWithTwitter">Sign in with Twitter</button>
    <div v-if="authSession">
      <h2>Welcome, {{ authSession.user }}</h2>
    </div>
  </div>
</template>