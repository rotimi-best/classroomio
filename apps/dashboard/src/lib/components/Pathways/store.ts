import { writable } from 'svelte/store';
import type { Writable } from 'svelte/store';
import type { Pathway } from '$lib/utils/types';

export const pathway: Writable<Pathway> = writable({
  id: 'pathway-one',
  title: 'pathwayOne',
  avatar: '',
  description: '',
  prerequisite: '', // should students take certificates in order of the arrangement or not
  is_published: false, // is pathway published or not
  is_certificate_downloadable: false, // to issue certificate on LMS or not
  courses_certificate: '', // to issue certificate for each courses or the learning path as a whole
  certificate_theme: 'professional', // certificate theme
  courses: [
    {
      id: '4653b37a-b0c4-4cf1-9dab-1ec4614a8643',
      avatar: '/images/org-landingpage-our-story.jpeg',
      title: 'Basic Fundamental of graphic design',
      description:
        'Begin with rudiment of  graphic design including typography, layouts, colours.....',
      lessonNumber: 5,
      studentNumber: 30,
      is_unlocked: true,
      is_completed: [
        {
          id: 1,
          course_id: '4653b37a-b0c4-4cf1-9dab-1ec4614a8643',
          profile_id: '',
          is_complete: true,
          created_at: '',
          updated_at: ''
        }
      ],
      is_published: false
    },
    {
      id: '73f92bda-f306-4c7b-88d3-d3a4ed37fb06',
      avatar: '/images/org-landingpage-our-story.jpeg',
      title: 'Establishing hierachy',
      description:
        'Begin with rudiment of  graphic design including typography, layouts, colours.....',
      lessonNumber: 5,
      studentNumber: 10,
      is_unlocked: false,
      is_completed: [
        {
          id: 1,
          course_id: '73f92bda-f306-4c7b-88d3-d3a4ed37fb06',
          profile_id: '',
          is_complete: true,
          created_at: '',
          updated_at: ''
        }
      ],
      is_published: false
    },
    {
      id: '41afd56e-938c-45be-8f71-e59465dacce1',
      avatar: '/images/org-landingpage-our-story.jpeg',
      title: 'Empathy',
      description:
        'Begin with rudiment of  graphic design including typography, layouts, colours.....',
      lessonNumber: 5,
      studentNumber: 3,
      is_unlocked: false,
      is_completed: [
        {
          id: 1,
          course_id: '41afd56e-938c-45be-8f71-e59465dacce1',
          profile_id: '',
          is_complete: true,
          created_at: '',
          updated_at: ''
        }
      ],
      is_published: false
    },
    {
      id: 'ef15e6ee-018d-48ab-a195-8030366aae06',
      avatar: '/images/org-landingpage-our-story.jpeg',
      title: 'Learn Typography',
      description:
        'Begin with rudiment of  graphic design including typography, layouts, colours.....',
      lessonNumber: 5,
      studentNumber: 2,
      is_unlocked: false,
      is_completed: [
        {
          id: 1,
          course_id: 'ef15e6ee-018d-48ab-a195-8030366aae06',
          profile_id: '',
          is_complete: true,
          created_at: '',
          updated_at: ''
        }
      ],
      is_published: true
    },
    {
      id: 'ef15e6ee-018d-48ab-a195-8030366aae06',
      avatar: '/images/org-landingpage-our-story.jpeg',
      title: 'Learn colours',
      description:
        'Begin with rudiment of  graphic design including typography, layouts, colours.....',
      lessonNumber: 5,
      studentNumber: 30,
      is_unlocked: false,
      is_completed: [
        {
          id: 1,
          course_id: 'ef15e6ee-018d-48ab-a195-8030366aae06',
          profile_id: '',
          is_complete: true,
          created_at: '',
          updated_at: ''
        }
      ],
      is_published: true
    }
  ]
});
