<script>
  import ChevronDown from 'carbon-icons-svelte/lib/ChevronDown.svelte';
  import TextAlignJustify from 'carbon-icons-svelte/lib/TextAlignJustify.svelte';
  import CloseLarge from 'carbon-icons-svelte/lib/CloseLarge.svelte';
  import { fly } from 'svelte/transition';
  import MachineLearningModel from 'carbon-icons-svelte/lib/MachineLearningModel.svelte';
  import ForumIcon from 'carbon-icons-svelte/lib/Forum.svelte';
  import CourseIcon from '$lib/Icons/CourseIcon.svelte';
  import MapCenter from 'carbon-icons-svelte/lib/MapCenter.svelte';

  let showsubNav = false;
  let showNav = false;

  function handleShow() {
    showsubNav = !showsubNav;
  }

  function handleShowNav() {
    showNav = !showNav;
  }

  const superpowers = [
    {
      key: 'coursemanagement',
      title: 'Course Management',
      subtitle: 'Advanced course management tools '
    },
    {
      key: 'customization',
      title: 'Customizations',
      subtitle: 'Customize your classroom to your needs'
    },
    {
      key: 'collaboration',
      title: 'Forum',
      subtitle: 'Seamlessly collaborate with your students'
    },
    {
      key: 'ai',
      title: 'AI Lesson Planner',
      subtitle: "10x Educator's productivity with AI"
    }
  ];
</script>

<div
  class="flex w-full justify-between items-center py-6 border-b-[1px] md:px-12 px-5 fixed top-0 z-[3000] filter backdrop-blur-xl shadow-sm bg-white"
>
  <a href="/" class="w-[20%]">
    <div class="flex items-center w-full">
      <img
        loading="lazy"
        width="28"
        height="28"
        src="/logo-512.svg"
        alt="classroomio logo"
        class="w-[40%] lg:w-[15%]"
      />
      <h1 class="text-xs md:text-lg font-medium ml-2">ClassroomIO</h1>
    </div>
  </a>

  <nav class="w-[40%] hidden md:hidden lg:block">
    <ul class="flex items-center justify-between w-full gap-2">
      <!--  -->
      <li class="text-gray-800 font-semibold text-sm cursor-pointer relative">
        <button class="flex items-center" on:click={() => (showNav = !showNav)}
          >Our Superpowers <ChevronDown class="ml-2" /></button
        >
        {#if showNav}
          <div
            class="absolute w-[24rem] top-10 -left-10 border px-5 py-5 rounded-[30px] shadow-slate-700 z-[3001] bg-white"
          >
            {#each superpowers as superpower}
              <a
                class="flex justify-between items-center w-full rounded-lg hover:bg-slate-100 p-5 mb-4"
                href="/#{superpower.key}"
                on:click={() => (showNav = !showNav)}
              >
                {#if superpower.key === 'coursemanagement'}
                  <CourseIcon />
                {:else if superpower.key === 'customization'}
                  <MapCenter size={24} />
                {:else if superpower.key === 'collaboration'}
                  <ForumIcon size={24} />
                {:else if superpower.key === 'ai'}
                  <MachineLearningModel size={24} />
                {/if}
                <div class="w-[86%] text-start">
                  <h3 class="font-semibold text-sm text-gray-700">
                    {superpower.title}
                  </h3>
                  <p class="font-normal text-sm text-gray-600">
                    {superpower.subtitle}
                  </p>
                </div>
              </a>
            {/each}
          </div>
        {/if}
      </li>
      <!-- More Features -->
      <!-- <a href="/#morefeatures">
        <li class="text-gray-800 font-semibold text-sm cursor-pointer">More features</li>
      </a> -->
      <!-- Pricing -->
      <a href="/#pricing">
        <li class="text-gray-800 font-semibold text-sm cursor-pointer">Pricing</li>
      </a>
      <!-- Docs -->
      <a href="/docs" target="_blank">
        <li class="text-gray-800 font-semibold text-sm cursor-pointer">Docs</li>
      </a>
      <!-- Blog -->
      <a href="/blog">
        <li class="text-gray-800 font-semibold text-sm cursor-pointer">Blog</li>
      </a>
    </ul>
  </nav>

  <div class="justify-between items-center flex-row hidden md:hidden lg:flex">
    <!-- <button
      class="bg-blue-700 text-white text-sm font-medium px-4 py-1.5 rounded-md mr-5"
    >
      Sign Up
    </button> -->
    <a href="/discord" target="_blank">
      <img
        loading="lazy"
        alt="discord logo"
        src="/discord-blue.png"
        class="w-8 h-6 mr-4 cursor-pointer"
      />
    </a>
    <a href="/github" target="_blank">
      <img
        loading="lazy"
        alt="github logo"
        src="/github-mark.png"
        class="w-6 h-6 mr-4 cursor-pointer"
      />
    </a>
    <a
      class="font-medium text-sm after:content-['→'] after:ml-2"
      href="https://app.classroomio.com"
    >
      Dashboard
    </a>
  </div>

  <button
    type="button"
    aria-label="Hamburger Menu"
    class="block md:block lg:hidden"
    on:click={handleShowNav}><TextAlignJustify size={24} /></button
  >

  <!-- burger menu -->
  {#if showNav}
    <div
      in:fly={{ x: 20, duration: 700 }}
      out:fly={{ x: 20, duration: 400 }}
      class="w-[60%] md:w-[40%] h-[100vh] border-2 sm:block lg:hidden px-3 pt-3 pb-2 md:p-7 absolute right-0 top-0 bg-white"
    >
      <div class="flex justify-between py-2 mb-5">
        <img
          loading="lazy"
          width="20"
          height="20"
          src="/logo-512.svg"
          alt="classroomio logo"
          class="w-[15%]"
        />
        <button on:click={handleShowNav}><CloseLarge size={24} class="mr-5" /></button>
      </div>
      <nav class="">
        <ul class="flex items-center flex-col lg:flex-row justify-between w-full">
          <!--  -->
          <li class="text-gray-800 font-semibold text-sm md:text-lg cursor-pointer w-full">
            <button
              class="w-full flex items-center justify-between hover:bg-gray-100 py-3 px-4 rounded-lg"
              on:click={handleShow}
            >
              Our Superpowers <ChevronDown />
            </button>
            {#if showsubNav}
              <div in:fly={{ y: -20, duration: 700 }} out:fly={{ y: 20, duration: 400 }}>
                {#each superpowers as superpower}
                  <a href="/#{superpower.key}">
                    <p
                      class="font-normal text-xs text-gray-700 hover:bg-gray-100 rounded-lg py-2.5 pl-5"
                    >
                      {superpower.title}
                    </p>
                  </a>
                {/each}
              </div>
            {/if}
          </li>
          <!-- Pricing -->
          <li
            class="text-gray-800 font-semibold text-sm md:text-lg cursor-pointer hover:bg-gray-100 py-3 px-4 rounded-xl w-full"
          >
            <a on:click={handleShowNav} href="/#pricing"> Pricing </a>
          </li>

          <!-- Docs -->
          <li
            class="text-gray-800 font-semibold text-sm md:text-lg cursor-pointer hover:bg-gray-100 py-3 px-4 rounded-md w-full"
          >
            <a on:click={handleShowNav} href="/docs" target="_blank"> Docs </a>
          </li>

          <!-- Blog -->
          <li
            class="text-gray-800 font-semibold text-sm md:text-lg cursor-pointer hover:bg-gray-100 py-3 px-4 rounded-md w-full"
          >
            <a on:click={handleShowNav} href="/blog"> Blog </a>
          </li>

          <!-- More Features -->
          <li
            class="text-gray-800 font-semibold text-sm md:text-lg cursor-pointer hover:bg-gray-100 py-3 px-4 rounded-md w-full"
          >
            <a on:click={handleShowNav} href="/#morefeatures"> More features </a>
          </li>
        </ul>
      </nav>
      <div class="flex items-start flex-col gap-y-2 mt-5 border-t-[1px] pt-5">
        <!-- <button
          class="text-black font-semibold rounded-md mr-10 w-full text-left py-4 px-4 hover:bg-gray-100 text-sm md:text-lg"
          >Sign Up</button
        > -->
        <a
          href="/discord"
          target="_blank"
          class="flex items-center rounded-md after:ml-2 w-full text-left py-4 px-4 hover:bg-gray-100 text-sm md:text-lg"
        >
          <img
            loading="lazy"
            alt="discord logo"
            src="/discord-blue.png"
            class="w-8 h-6 mr-2 cursor-pointer"
          />
          <span>Discord</span>
        </a>
        <a
          href="/github"
          target="_blank"
          class="flex items-center rounded-md after:ml-2 w-full text-left py-4 px-4 hover:bg-gray-100 text-sm md:text-lg"
        >
          <img
            loading="lazy"
            alt="github logo"
            src="/github-mark.png"
            class="w-6 h-6 mr-3 cursor-pointer"
          />
          <span>Github</span>
        </a>
        <a
          class="font-semibold after:content-['→'] rounded-md after:ml-2 w-full text-left py-4 px-4 hover:bg-gray-100 text-sm md:text-lg"
          href="https://app.classroomio.com"
        >
          Dashboard
        </a>
      </div>
    </div>
  {/if}
</div>
