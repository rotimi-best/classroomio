<script>
  import RoleBasedSecurity from '../RoleBasedSecurity/index.svelte';
  import PageNav from '../PageNav/index.svelte';
  import MODES from '$lib/utils/constants/mode';
  import PrimaryButton from '$lib/components/PrimaryButton/index.svelte';
  import PageBody from '../PageBody/index.svelte';
  import { course } from './store';
  import { updateCourse } from '$lib/utils/services/courses';
  import TextEditor from '$lib/components/TextEditor/index.svelte';
  import HtmlRender from '$lib/components/HTMLRender/HTMLRender.svelte';

  let mode = MODES.view;
  let isDirty = false;

  async function handleModeChange() {
    if (mode === MODES.edit) {
      mode = MODES.view;
      if (isDirty) {
        const { overview, id } = $course;
        await updateCourse(id, undefined, { overview });
      }
    } else {
      mode = MODES.edit;
    }
  }
</script>

<PageNav title="Overview" disableSticky={true}>
  <svelte:fragment slot="widget">
    <RoleBasedSecurity allowedRoles={[1, 2]}>
      <div class="flex items-center">
        <PrimaryButton
          className="mr-2"
          label={mode === MODES.edit ? 'Save' : 'Edit'}
          onClick={handleModeChange}
        />
      </div>
    </RoleBasedSecurity>
  </svelte:fragment>
</PageNav>

<PageBody width="max-w-3xl px-3">
  {#if mode === MODES.edit}
    <TextEditor
      value={$course.overview}
      onChange={(html) => {
        isDirty = true;
        $course.overview = html;
      }}
      placeholder="Write your overview here"
      height={700}
    />
  {:else}
    <HtmlRender className="p-2" content={$course.overview || ''} />
  {/if}
</PageBody>
