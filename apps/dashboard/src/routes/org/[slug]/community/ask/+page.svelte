<script lang="ts">
  import { goto } from '$app/navigation';
  import { Dropdown } from 'carbon-components-svelte';
  import ArrowLeftIcon from 'carbon-icons-svelte/lib/ArrowLeft.svelte';
  import { currentOrgPath, currentOrg } from '$lib/utils/store/org';
  import PrimaryButton from '$lib/components/PrimaryButton/index.svelte';
  import { askCommunityValidation } from '$lib/utils/functions/validator';
  import { supabase } from '$lib/utils/functions/supabase';
  import { snackbar } from '$lib/components/Snackbar/store';
  import generateSlug from '$lib/utils/functions/generateSlug';
  import TextEditor from '$lib/components/TextEditor/index.svelte';
  import TextField from '$lib/components/Form/TextField.svelte';
  import { profile } from '$lib/utils/store/user';
  import { fetchCourses } from '$lib/components/Courses/api';

  export let data;

  let errors: {
    title?: string;
    courseId?: string;
  } = {};
  let fields = {
    title: '',
    body: '',
    courseId: ''
  };

  let fetchedCourses = [];

  async function getCourses(userId: string | null, orgId: string) {
    const coursesResults = await fetchCourses(userId, orgId);
    fetchedCourses = coursesResults.allCourses;
  }

  async function handleSave() {
    errors = askCommunityValidation(fields);
    console.log('handleSave errors', errors);

    if (Object.keys(errors).length) {
      return;
    }

    const { data: question, error } = await supabase
      .from('community_question')
      .insert({
        title: fields.title,
        body: fields.body,
        organization_id: $currentOrg.id,
        author_profile_id: $profile.id,
        votes: 0,
        slug: generateSlug(fields.title),
        course_id: fields.courseId
      })
      .select();

    if (error) {
      console.error('Error: asking question', error);
      snackbar.error('Error - Please try again later');
    } else {
      const slug = question[0]?.slug;

      console.log('Success: asking question', question, slug);
      snackbar.success('Question Submitted!');
      goto(`${$currentOrgPath}/community/${slug}`);
    }
  }

  $: {
    if ($profile.id && $currentOrg.id) {
      getCourses($profile.id, $currentOrg.id);
    }
  }
</script>

<svelte:head>
  <title>Ask the Community - ClassroomIO</title>
</svelte:head>

<section class="w-full md:max-w-3xl md:mx-auto">
  <div class="p-5">
    <a
      class="text-gray-500 dark:text-white text-md flex items-center"
      href={`${$currentOrgPath}/community`}
    >
      <ArrowLeftIcon size={24} class="carbon-icon dark:text-white" /> Go Back
    </a>
    <div class="flex items-center gap-12 justify-between">
      <h1 class="dark:text-white text-2xl md:text-3xl font-bold">Ask the community</h1>
      <PrimaryButton label="Publish" onClick={handleSave} />
    </div>
  </div>

  <div class="mb-3 p-2 flex gap-x-5 justify-between">
    <TextField
      bind:value={fields.title}
      placeholder="Title"
      errorMessage={errors.title}
      className="w-[75%]"
    />
    <Dropdown
      class="w-[25%]"
      size="xl"
      label="Select Course"
      invalid={!!errors.courseId}
      invalidText={errors.courseId}
      items={fetchedCourses.map((course) => ({ id: course.id, text: course.title }))}
      bind:selectedId={fields.courseId}
    />
  </div>
  <div class="px-2">
    <TextEditor
      bind:value={fields.body}
      placeholder="Ask the community any question you might have"
      onChange={(html) => (fields.body = html)}
    />
  </div>
</section>
