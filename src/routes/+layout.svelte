<script>
  import '../app.css';
  import { Navbar, NavBrand, NavHamburger, NavUl, NavLi, MegaMenu, DarkMode } from 'flowbite-svelte';
    import { ChevronDownOutline } from 'flowbite-svelte-icons';
    import { onMount } from "svelte";
    import { isDark } from '$lib/store';

    let menu = [
      { name: 'About us', href: '/about' },
      { name: 'Blog', href: '/blog' },
      { name: 'Contact us', href: '/contact' },
      { name: 'Library', href: '/library' },
      { name: 'Newsletter', href: '/news' },
      { name: 'Support Center', href: '/support' },
      { name: 'Resources', href: '/resource' },
      { name: 'Playground', href: '/play' },
      { name: 'Terms', href: '/terms' },
      { name: 'Pro Version', href: '/pro' },
      { name: 'License', href: '/license' }
    ];

    onMount(() => {
      if (localStorage.getItem('color-theme') === 'dark' || (!('color-theme' in localStorage) && window.matchMedia('(prefers-color-scheme: dark)').matches)) {
        $isDark = true;
      }
    });
</script>

<Navbar let:hidden let:toggle>
  <NavBrand href="/">
    <div class="me-3 h-6 sm:h-9" >
    </div>
    <span class="self-center whitespace-nowrap text-xl font-semibold dark:text-white">App</span>
  </NavBrand>
  <NavHamburger on:click={toggle} />
  <NavUl {hidden}>
    <NavLi href="/">Home</NavLi>
    <NavLi href="/get-started">Get Started</NavLi>
    <!-- <NavLi href="#">
    </NavLi> -->
    <DarkMode size="lg" btnClass="m-0" />
  </NavUl>
</Navbar>
<main class="content max-w-6xl mx-auto">
  <slot />
</main>